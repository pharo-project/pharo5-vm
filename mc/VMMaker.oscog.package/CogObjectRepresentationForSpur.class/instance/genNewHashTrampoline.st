initialization
genNewHashTrampoline
	"In non sista VM this is used only from the identityHash primitive, hence only the result of the trampoline, the hash, should be in ReceiverResultReg, other registers can just be ignored.
	In the sista VM, the inlined hash operation requires registers to be saved"
	<inline: true>
	<option: #SistaVM>
	^ cogit
		genTrampolineFor: 1
		called: 'newHashTrampoline'
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: (CallerSavedRegisterMask bitClear: (cogit registerMaskFor: ReceiverResultReg))
		pushLinkReg: true
		resultReg: ReceiverResultReg
		appendOpcodes: true