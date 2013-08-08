debugging
checkIntegrityOfObjectReferencesInCode: fullGCFlag
	<api>
	"Answer if all references to objects in machine-code are valid."	
	| cogMethod ok count |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	ok := true.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[cogMethod cmRefersToYoung ifTrue:
				[(count := methodZone occurrencesInYoungReferrers: cogMethod) ~= 1 ifTrue:
					[self print: 'young referrer CM '; printHex: cogMethod asInteger.
					 count = 0
						ifTrue: [self print: ' is not in youngReferrers'; cr]
						ifFalse: [self print: ' is in youngReferrers '; printNum: count; print: ' times!'; cr].
					 ok := false]].
			 (objectRepresentation checkValidObjectReference: cogMethod selector) ifFalse:
				[self print: 'object leak in CM '; printHex: cogMethod asInteger; print: ' selector'; cr.
				 ok := false].
			 cogMethod cmType = CMMethod
				ifTrue:
					[self assert: cogMethod objectHeader = objectMemory nullHeaderForMachineCodeMethod.
					 (objectRepresentation checkValidObjectReference: cogMethod methodObject) ifFalse:
						[self print: 'object leak in CM '; printHex: cogMethod asInteger; print: ' methodObject'; cr.
						 ok := false].
					 (self mapFor: cogMethod
						 performUntil: #checkIfValidObjectRef:pc:cogMethod:
						 arg: cogMethod asInteger) ~= 0
							ifTrue: [ok := false].
					 fullGCFlag ifFalse:
						[(((objectMemory isYoung: cogMethod methodObject)
						    or: [objectMemory isYoung: cogMethod selector])
						   and: [cogMethod cmRefersToYoung not]) ifTrue:
							[self print: 'CM '; printHex: cogMethod asInteger; print: ' refers to young but not marked as such'; cr.
							 ok := false]]]
				ifFalse:
					[cogMethod cmType = CMClosedPIC
						ifTrue:
							[(self checkValidObjectReferencesInClosedPIC: cogMethod) ifFalse:
								[ok := false]]
						ifFalse:
							[cogMethod cmType = CMOpenPIC
								ifTrue:
									[(self mapFor: cogMethod
										performUntil: #checkIfValidObjectRef:pc:cogMethod:
										arg: cogMethod asInteger) ~= 0
											ifTrue: [ok := false]]]]].
		cogMethod := methodZone methodAfter: cogMethod].
	^ok