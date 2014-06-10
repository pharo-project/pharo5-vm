initialization
generateNewspeakRuntime
	<option: #NewspeakVM>
	| jumpMiss jumpItsTheReceiverStupid |
	<var: #jumpMiss type: #'AbstractInstruction *'>
	<var: #jumpItsTheReceiverStupid type: #'AbstractInstruction *'>
	"Generate the non-send runtime support for Newspeak, explicit outer and implicit receiver.
	 The dynamic frequency of explicit outer is so low we merely call an interpreter routine."
	ceExplicitReceiverTrampoline := self genTrampolineFor: #ceExplicitReceiverAt:
										called: 'ceExplicitReceiverTrampoline'
										arg: SendNumArgsReg
										result: ReceiverResultReg.
	"Cached push implicit receiver implementation.  Caller looks like
				mov selector, ClassReg
				call ceImplicitReceiver
				br continue
		Lclass:	.word
		Lmixin::	.word
		continue:
	 If class matches class of receiver then mixin contains either 0 or the implicit receiver.
	 If 0, answer the actual receiver, otherwise the mixin.
	 Generate the class fetch and cache probe inline for speed. Smashes Arg0Reg and caller-saved regs."
	opcodeIndex := 0.
	self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg.
	objectRepresentation
		genGetClassObjectOf: ReceiverResultReg
		into: ClassReg
		scratchReg: TempReg
		instRegIsReceiver: true. "don't follow forwarding pointer here"
	self MoveMw: 0 r: SPReg R: TempReg.
	self MoveMw: backEnd jumpShortByteSize r: TempReg R: Arg1Reg.
	self CmpR: ClassReg R: Arg1Reg.
	jumpMiss := self JumpNonZero: 0.
	self MoveMw: backEnd jumpShortByteSize + BytesPerOop r: TempReg R: ClassReg.
	self CmpCq: 0 R: ClassReg.
	jumpItsTheReceiverStupid := self JumpZero: 0.
	self MoveR: ClassReg R: ReceiverResultReg.
	jumpItsTheReceiverStupid jmpTarget: (self RetN: 0).
	jumpMiss jmpTarget: self Label.
	ceImplicitReceiverTrampoline := self
										genTrampolineFor: #ceImplicitReceiverFor:receiver:class:
										called: 'ceImplicitReceiverTrampoline'
										numArgs: 3
										arg: SendNumArgsReg
										arg: ReceiverResultReg
										arg: ClassReg
										arg: nil
										saveRegs: false
										pushLinkReg: true
										resultReg: ReceiverResultReg
										appendOpcodes: true