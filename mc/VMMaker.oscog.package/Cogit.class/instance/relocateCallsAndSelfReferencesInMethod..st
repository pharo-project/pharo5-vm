compaction
relocateCallsAndSelfReferencesInMethod: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	| refDelta callDelta |
	refDelta := cogMethod objectHeader.
	callDelta := backEnd zoneCallsAreRelative ifTrue: [refDelta] ifFalse: [0].
	
	self assert: (cogMethod cmType = CMMethod or: [cogMethod cmType = CMOpenPIC]).
	self assert: (backEnd callTargetFromReturnAddress: cogMethod asInteger + missOffset)
				= (cogMethod cmType = CMMethod
					ifTrue: [self methodAbortTrampolineFor: cogMethod cmNumArgs]
					ifFalse: [self picAbortTrampolineFor: cogMethod cmNumArgs]).
	backEnd relocateCallBeforeReturnPC: cogMethod asInteger + missOffset by: callDelta negated.
	self mapFor: cogMethod
		performUntil: #relocateIfCallOrMethodReference:mcpc:delta:
		arg: refDelta