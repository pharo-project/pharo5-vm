initialization
genInnerPICAbortTrampoline: name
	"Generate the abort for a PIC.  This abort performs either a call of
	 ceInterpretMethodFromPIC:receiver: to handle invoking an uncogged
	 target or a call of ceMNUFromPICMNUMethod:receiver: to handle an
	 MNU dispatch in a closed PIC.  It distinguishes the two by testing
	 ClassReg.  If the register is zero then this is an MNU."
	<var: #name type: #'char *'>
	| jumpMNUCase |
	<var: #jumpMNUCase type: #'AbstractInstruction *'>
	self CmpCq: 0 R: ClassReg.
	jumpMNUCase := self JumpZero: 0.
	self compileTrampolineFor: #ceInterpretMethodFromPIC:receiver:
		numArgs: 2
		arg: SendNumArgsReg
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		saveRegs: false
		pushLinkReg: true
		resultReg: nil.
	jumpMNUCase jmpTarget: self Label.
	^self genTrampolineFor: #ceMNUFromPICMNUMethod:receiver:
		called: name
		numArgs: 2
		arg: SendNumArgsReg
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		saveRegs: false
		pushLinkReg: true
		resultReg: nil
		appendOpcodes: true