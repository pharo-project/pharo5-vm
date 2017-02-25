type inference
inferReturnTypeFromReturnsIn: aCodeGen
	"Attempt to infer the return type of the receiver from returns in the parse tree."

	"this for determining which returns have which return types:"
	"aCodeGen
		pushScope: declarations
		while: [parseTree
				nodesSelect: [:n| n isReturn]
				thenCollect: [:n| | s |
					s := Set new.
					self addTypesFor: n expression to: s in: aCodeGen.
					{n. s}]]"
			
	aCodeGen maybeBreakForTestToInline: selector in: self.
	returnType ifNotNil: [^self].
	aCodeGen
		pushScope: declarations
		while:
			[| hasReturn returnTypes |
			 hasReturn := false.
			 returnTypes := Set new.
			 "Debug:
			 (| rettypes |
			  rettypes := Dictionary new.
			  parseTree nodesDo:
				[:node|
				node isReturn ifTrue:
					[| types |
					 self addTypesFor: node expression to: (types := Set new) in: aCodeGen.
					 rettypes at: node expression put: types]].
			  rettypes)"
			 parseTree nodesDo:
				[:node|
				node isReturn ifTrue:
					[hasReturn := true.
					 "If we encounter a send of an as-yet-untyped method then abort,
					  retrying and computing the type when that method is fully typed."
					 (self addTypesFor: node expression to: returnTypes in: aCodeGen) ifTrue:
						[^self]]].
			returnTypes remove: #implicit ifAbsent: [].
			returnTypes := aCodeGen harmonizeReturnTypesIn: returnTypes.
			hasReturn
				ifTrue:
					[returnTypes size > 1 ifTrue:
						[| message |
						 message := String streamContents:
										[:s|
										 s nextPutAll: 'conflicting return types '.
										 returnTypes
											do: [:t| s nextPutAll: t]
											separatedBy: [s nextPutAll: ', '].
										 s nextPutAll: ' in '; nextPutAll: selector; cr].
						 Notification signal: message.
						 aCodeGen logger show: message].
					 returnTypes size = 1 ifTrue:
						[self returnType: returnTypes anyOne]]
				ifFalse:
					[self returnType: (aCodeGen implicitReturnTypeFor: selector)]]