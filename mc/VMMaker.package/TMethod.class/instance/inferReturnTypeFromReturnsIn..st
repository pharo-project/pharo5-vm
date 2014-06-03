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
	returnType ifNil: "the initial default"
		[aCodeGen
			pushScope: declarations
			while:
				[| hasReturn returnTypes |
				 hasReturn := false.
				 returnTypes := Set new.
				 parseTree nodesDo:
					[:node|
					node isReturn ifTrue:
						[hasReturn := true.
						 self addTypesFor: node expression to: returnTypes in: aCodeGen]].
				returnTypes remove: #implicit ifAbsent: [].
				returnTypes := aCodeGen harmonizeReturnTypesIn: returnTypes.
				hasReturn
					ifTrue:
						[returnTypes size > 1 ifTrue:
							[aCodeGen logger show:
								(String streamContents:
									[:s|
									 s nextPutAll: 'conflicting return types '.
									 returnTypes
										do: [:t| s nextPutAll: t]
										separatedBy: [s nextPutAll: ', '].
									 s nextPutAll: ' in '; nextPutAll: selector; cr])].
						 returnTypes size = 1 ifTrue:
							[self returnType: returnTypes anyOne]]
					ifFalse:
						[self returnType: (aCodeGen implicitReturnTypeFor: selector)]]]