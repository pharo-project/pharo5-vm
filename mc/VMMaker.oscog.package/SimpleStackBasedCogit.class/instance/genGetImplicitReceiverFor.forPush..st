bytecode generators
genGetImplicitReceiverFor: selector forPush: forPushSendBar
	"Cached implicit receiver implementation.  If objectRepresentation doesn't support
	 pinning then caller looks like
				mov selector, ClassReg
				call ceImplicitReceiverTrampoline
				br continue
		Lclass	.word
		Lmixin:	.word
		continue:
	 If objectRepresentation supports pinning then caller looks like
				mov Lclass, Arg1Reg
				mov selector, SendNumArgsReg
				call ceImplicitReceiver
	 and Lclass: .word; Lmixin: .word is somewhere on the heap.

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
	self assert: (self noAssertMethodClassAssociationOf: methodObj) ~= objectMemory nilObject.
	self assert: needsFrame.
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	objectRepresentation canPinObjects ifTrue:
		[self MoveCw: theIRCs + (2 * BytesPerOop * indexOfIRC) R: Arg1Reg.
		 self MoveCw: selector R: SendNumArgsReg.
		 self CallNewspeakSend: ceImplicitReceiverTrampoline.
		 indexOfIRC := indexOfIRC + 1.
		 ^0].
	self MoveCw: selector R: SendNumArgsReg.
	self CallNewspeakSend: ceImplicitReceiverTrampoline.
	skip := self Jump: 0.
	self Fill32: 0.
	self Fill32: 0.
	skip jmpTarget: self Label.
	^0