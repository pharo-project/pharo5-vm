initialization
generateNewspeakRuntime
	<option: #NewspeakVM>
	| jumpMiss jumpItsTheReceiverStupid retpcReg |
	<var: #jumpMiss type: #'AbstractInstruction *'>
	<var: #jumpItsTheReceiverStupid type: #'AbstractInstruction *'>
	"Generate the non-send runtime support for Newspeak, explicit outer and implicit receiver.
	 The dynamic frequency of explicit outer is so low we merely call an interpreter routine."
	ceExplicitReceiverTrampoline := self genTrampolineFor: #ceExplicitReceiverAt:
										called: 'ceExplicitReceiverTrampoline'
										arg: SendNumArgsReg
										result: ReceiverResultReg.
	"Cached push implicit receiver implementation.  If objectRepresentation doesn't support
	 pinning then caller looks like
				mov selector, SendNumArgsReg
				call ceImplicitReceiver
				br continue
		Lclass:	.word
		Lmixin::	.word
		continue:
	 If objectRepresentation supports pinning then caller looks like
				mov Lclass, Arg1Reg
				mov selector, SendNumArgsReg
				call ceImplicitReceiver
	 and Lclass: .word; Lmixin: .word is somewhere on the heap.

	 If class tag matches class of receiver then mixin contains either 0 or the implicit receiver.
	 If 0, answer the actual receiver, otherwise the mixin.
	 Generate the class fetch and cache probe inline for speed.
	 Smashes Arg1Reg, RegClass and caller-saved regs."
	opcodeIndex := 0.
	self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg.
	objectRepresentation
		genGetInlineCacheClassTagFrom: ReceiverResultReg
		into: ClassReg
		forEntry: false.
	objectRepresentation canPinObjects
		ifTrue:
			[self MoveMw: 0 r: Arg1Reg R: TempReg.
			 self CmpR: ClassReg R: TempReg.
			 jumpMiss := self JumpNonZero: 0.
			 self MoveMw: BytesPerOop r: Arg1Reg R: TempReg.
			 self CmpCq: 0 R: TempReg.
			 jumpItsTheReceiverStupid := self JumpZero: 0.
			 self MoveR: TempReg R: ReceiverResultReg.
			 jumpItsTheReceiverStupid jmpTarget: (self RetN: 0).
			 jumpMiss jmpTarget: self Label.
			 ceImplicitReceiverTrampoline := self
												genTrampolineFor: #ceImplicitReceiverFor:receiver:cache:
												called: 'ceImplicitReceiverTrampoline'
												numArgs: 3
												arg: SendNumArgsReg
												arg: ReceiverResultReg
												arg: Arg1Reg
												arg: nil
												saveRegs: false
												pushLinkReg: true
												resultReg: ReceiverResultReg
												appendOpcodes: true]
		ifFalse:
			[backEnd hasLinkRegister
				ifTrue: [retpcReg := LinkReg]
				ifFalse: [self MoveMw: 0 r: SPReg R: (retpcReg := TempReg)].
			 self MoveMw: 0 r: SPReg R: retpcReg.
			 self MoveMw: backEnd jumpShortByteSize r: retpcReg R: Arg1Reg.
			 self CmpR: ClassReg R: Arg1Reg.
			 jumpMiss := self JumpNonZero: 0.
			 self MoveMw: backEnd jumpShortByteSize + BytesPerOop r: retpcReg R: ClassReg.
			 self CmpCq: 0 R: ClassReg.
			 jumpItsTheReceiverStupid := self JumpZero: 0.
			 self MoveR: ClassReg R: ReceiverResultReg.
			 jumpItsTheReceiverStupid jmpTarget: (self RetN: 0).
			 jumpMiss jmpTarget: self Label.
			 ceImplicitReceiverTrampoline := self
												genTrampolineFor: #ceImplicitReceiverFor:receiver:
												called: 'ceImplicitReceiverTrampoline'
												numArgs: 2
												arg: SendNumArgsReg
												arg: ReceiverResultReg
												arg: nil
												arg: nil
												saveRegs: false
												pushLinkReg: true
												resultReg: ReceiverResultReg
												appendOpcodes: true]