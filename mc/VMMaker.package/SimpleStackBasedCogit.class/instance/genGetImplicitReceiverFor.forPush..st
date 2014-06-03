bytecode generators
genGetImplicitReceiverFor: selector forPush: forPushSendBar
	"Cached implicit receiver implementation.  Caller looks like
		mov selector, ClassReg
				call ceImplicitReceiverTrampoline
				br continue
		Lclass	.word
		Lmixin:	.word
		continue:
	 If class matches class of receiver then mixin contains either 0 or the implicit receiver.
	 If 0, answer the actual receiver.  This is done in the trampoline.
	 See generateNewspeakRuntime."

	| skip |
	<var: #skip type: #'AbstractInstruction *'>
	"N.B. For PC mapping either this is used for SendAbsentImplicit or for PushAbsentReceiver
	 but not both.  So any Newspeak instruction set has to choose either SendAbsentImplicit
	 or PushImplicitReceiver.  See isPCMappedAnnotation:alternateInstructionSet:"
	self assert: forPushSendBar = (self isPCMappedAnnotation: IsNSSendCall
										alternateInstructionSet: bytecodeSetOffset > 0).
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self assert: needsFrame.
	self MoveCw: selector R: SendNumArgsReg.
	self CallNewspeakSend: ceImplicitReceiverTrampoline.
	skip := self Jump: 0.
	self Fill32: 0.
	self Fill32: 0.
	skip jmpTarget: self Label.
	^0