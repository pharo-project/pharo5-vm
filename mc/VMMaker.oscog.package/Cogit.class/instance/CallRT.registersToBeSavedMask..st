compile abstract instructions
CallRT: callTarget registersToBeSavedMask: registersToBeSaved
	<returnTypeC: #'AbstractInstruction *'>
	| callerSavedRegsToBeSaved lastInst |
	<var: 'lastInst' type: #'AbstractInstruction *'>
	callerSavedRegsToBeSaved := callerSavedRegMask bitAnd: registersToBeSaved.

	backEnd maxAbstractGeneralPurposeReg to: backEnd minAbstractGeneralPurposeReg by: -1 do:
		[:reg|
		(reg ~= TempReg
		 and: [callerSavedRegsToBeSaved anyMask: (self registerMaskFor: reg)]) ifTrue:
			[self PushR: reg]].
	
	lastInst := self CallRT: callTarget.

	backEnd minAbstractGeneralPurposeReg to: backEnd maxAbstractGeneralPurposeReg do:
		[:reg|
		(reg ~= TempReg
		 and: [callerSavedRegsToBeSaved anyMask: (self registerMaskFor: reg)]) ifTrue:
			[lastInst := self PopR: reg]].

	^lastInst