debugging
checkIntegrityOfObjectReferencesInCode: gcModes
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
					[coInterpreter print: 'young referrer CM '; printHex: cogMethod asInteger.
					 count = 0
						ifTrue: [coInterpreter print: ' is not in youngReferrers'; cr]
						ifFalse: [coInterpreter print: ' is in youngReferrers '; printNum: count; print: ' times!'; cr].
					 ok := false]].
			 (objectRepresentation checkValidOopReference: cogMethod selector) ifFalse:
				[coInterpreter print: 'object leak in CM '; printHex: cogMethod asInteger; print: ' selector'; cr.
				 ok := false].
			 cogMethod cmType = CMMethod
				ifTrue:
					[self assert: cogMethod objectHeader = objectMemory nullHeaderForMachineCodeMethod.
					 (objectRepresentation checkValidObjectReference: cogMethod methodObject) ifFalse:
						[coInterpreter print: 'object leak in CM '; printHex: cogMethod asInteger; print: ' methodObject'; cr.
						 ok := false].
					 (objectMemory isOopCompiledMethod: cogMethod methodObject) ifFalse:
						[coInterpreter print: 'non-method in CM '; printHex: cogMethod asInteger; print: ' methodObject'; cr.
						 ok := false].
					 (self mapFor: cogMethod
						 performUntil: #checkIfValidOopRef:pc:cogMethod:
						 arg: cogMethod asInteger) ~= 0
							ifTrue: [ok := false].
					 (objectRepresentation hasSpurMemoryManagerAPI
					  or: [gcModes anyMask: GCModeNewSpace]) ifTrue:
						[(((objectMemory isYoungObject: cogMethod methodObject)
						    or: [objectMemory isYoung: cogMethod selector])
						   and: [cogMethod cmRefersToYoung not]) ifTrue:
							[coInterpreter print: 'CM '; printHex: cogMethod asInteger; print: ' refers to young but not marked as such'; cr.
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
										performUntil: #checkIfValidOopRef:pc:cogMethod:
										arg: cogMethod asInteger) ~= 0
											ifTrue: [ok := false]]]]].
		cogMethod := methodZone methodAfter: cogMethod].
	^ok