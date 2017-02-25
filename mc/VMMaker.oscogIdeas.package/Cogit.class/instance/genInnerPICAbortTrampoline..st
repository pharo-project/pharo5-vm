initialization
genInnerPICAbortTrampoline: name
	"Generate the abort for a PIC.  This abort performs either a call of
	 ceInterpretMethodFromPIC:receiver: to handle invoking an uncogged target
	 or a call of ceMNUFromPICMNUMethod:receiver: to handle an MNU dispatch
	 in a closed PIC.  It distinguishes the two by testing ClassReg.  If the register
	 is zero then this is an MNU.
	
	 This poses a problem in 32-bit Spur, where zero is the cache tag for immediate
	 characters (tag pattern 2r10) because SmallIntegers have tag patterns 2r11
	 and 2r01, so anding with 1 reduces these to 0 & 1.  We solve the ambiguity by
	 patching send sites with a 0 cache tag to open PICs instead of closed PICs."
	<var: #name type: #'char *'>
	| jumpMNUCase |
	<var: #jumpMNUCase type: #'AbstractInstruction *'>
	self CmpCq: self picAbortDiscriminatorValue R: ClassReg.
	jumpMNUCase := self JumpZero: 0.
	self compileTrampolineFor: #ceInterpretMethodFromPIC:receiver:
		numArgs: 2
		arg: SendNumArgsReg
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: false
		resultReg: NoReg.
	jumpMNUCase jmpTarget: self Label.
	^self genTrampolineFor: #ceMNUFromPICMNUMethod:receiver:
		called: name
		numArgs: 2
		arg: SendNumArgsReg
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: false
		resultReg: NoReg
		appendOpcodes: true