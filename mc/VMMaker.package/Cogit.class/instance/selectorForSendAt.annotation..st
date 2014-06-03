simulation only
selectorForSendAt: mcpc annotation: annotation
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
						[backEnd inlineCacheTagAt: mcpc].
	^coInterpreter isCurrentImageFacade
		ifTrue: [coInterpreter objectForOop: selector]
		ifFalse: [selector]