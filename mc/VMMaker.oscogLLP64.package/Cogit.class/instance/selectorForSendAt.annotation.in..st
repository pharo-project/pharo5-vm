simulation only
selectorForSendAt: mcpc annotation: annotation in: aCompiledMethod
	<doNotGenerate>
	| entryPoint offset targetMethod selector |
	entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
	selector := entryPoint > methodZoneBase
					ifTrue: "It's a linked send."
						[self
							offsetAndSendTableFor: entryPoint
							annotation: annotation
							into: [:off :table| offset := off].
						targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
						targetMethod selector]
					ifFalse:
						[self inlineCacheTagsAreIndexes
							ifTrue: [self selectorFromSelectorIndex: (backEnd inlineCacheTagAt: mcpc) signedIntFromLong
										in: aCompiledMethod]
							ifFalse: [backEnd inlineCacheTagAt: mcpc]].
	^(annotation ~= IsNSSendCall and: [coInterpreter isCurrentImageFacade])
		ifTrue: [coInterpreter objectForOop: selector]
		ifFalse: [selector]