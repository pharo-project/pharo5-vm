compile abstract instructions
CallRT: callTarget registersToBeSavedMask: registersToBeSaved
	<returnTypeC: #'AbstractInstruction *'>
	| callerSavedRegsToBeSaved lastInst |
	<var: 'lastInst' type: #'AbstractInstruction *'>
	callerSavedRegsToBeSaved := callerSavedRegMask bitAnd: registersToBeSaved.

	GPRegMax to: GPRegMin by: -1 do:
		[:reg|
		(reg ~= TempReg
		 and: [callerSavedRegsToBeSaved anyMask: (self registerMaskFor: reg)]) ifTrue:
			[self PushR: reg]].
	
	lastInst := self CallRT: callTarget.

	GPRegMin to: GPRegMax do:
		[:reg|
		(reg ~= TempReg
		 and: [callerSavedRegsToBeSaved anyMask: (self registerMaskFor: reg)]) ifTrue:
			[lastInst := self PopR: reg]].

	^lastInst