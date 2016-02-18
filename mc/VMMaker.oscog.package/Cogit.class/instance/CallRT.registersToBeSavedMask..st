compile abstract instructions
CallRT: callTarget registersToBeSavedMask: registersToBeSaved
	<returnTypeC: #'AbstractInstruction *'>
	| callerSavedRegsToBeSaved lastInst reg registersToBePushed |
	<var: 'lastInst' type: #'AbstractInstruction *'>
	callerSavedRegsToBeSaved := callerSavedRegMask bitAnd: registersToBeSaved.

	registersToBePushed := callerSavedRegsToBeSaved.
	reg := 0.
	[registersToBePushed ~= 0] whileTrue:
		[(registersToBePushed anyMask: 1) ifTrue:
			[self PushR: reg].
		 reg := reg + 1.
		 registersToBePushed := registersToBePushed >>> 1].
	
	lastInst := self CallRT: callTarget.

	[reg >= 0] whileTrue:
		[(callerSavedRegsToBeSaved anyMask: 1 << reg) ifTrue:
			[lastInst := self PopR: reg].
		 reg := reg - 1].

	^lastInst