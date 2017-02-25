compile abstract instructions
CallFullRT: callTarget registersToBeSavedMask: registersToBeSaved
	<returnTypeC: #'AbstractInstruction *'>
	| callerSavedRegsToBeSaved lastInst reg registersToBePushed |
	<var: 'lastInst' type: #'AbstractInstruction *'>
	callerSavedRegsToBeSaved := CallerSavedRegisterMask bitAnd: registersToBeSaved.

	backEnd canPushPopMultipleRegisters
		ifTrue: [backEnd genPushRegisterMask: callerSavedRegsToBeSaved]
		ifFalse:
			[registersToBePushed := callerSavedRegsToBeSaved.
			 reg := 0.
			 [registersToBePushed ~= 0] whileTrue:
				[(registersToBePushed anyMask: 1) ifTrue:
					[self PushR: reg].
				 reg := reg + 1.
				 registersToBePushed := registersToBePushed >>> 1]].

	lastInst := self CallFullRT: callTarget.

	backEnd canPushPopMultipleRegisters
		ifTrue: [^backEnd genPopRegisterMask: callerSavedRegsToBeSaved]
		ifFalse:
			[[reg >= 0] whileTrue:
				[(callerSavedRegsToBeSaved anyMask: 1 << reg) ifTrue:
					[lastInst := self PopR: reg].
				 reg := reg - 1].

			 ^lastInst]