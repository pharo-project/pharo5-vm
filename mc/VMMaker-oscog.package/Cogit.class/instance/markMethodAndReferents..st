jit - api
markMethodAndReferents: aCogMethod
	<api>
	<var: #aCogMethod type: #'CogBlockMethod *'>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	self assert: (aCogMethod cmType = CMMethod
				or: [aCogMethod cmType = CMBlock]).
	cogMethod := aCogMethod cmType = CMMethod
					ifTrue: [self cCoerceSimple: aCogMethod to: #'CogMethod *']
					ifFalse: [aCogMethod cmHomeMethod].
	cogMethod cmUsageCount: CMMaxUsageCount.
	self mapFor: cogMethod
		performUntil: #incrementUsageOfTargetIfLinkedSend:mcpc:ignored:
		arg: 0