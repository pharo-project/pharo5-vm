initialization
genStoreTrampolineCalled: trampolineName
	"This can be entered in one of two states, depending on TempReg. 
	TempReg = 0 => store check
	TempReg > 0 => immutability failure
	TempReg holds index + 1 in this case as the value 0 is reserved for store checks.
	In addition the 0 value is convenient to save one instruction for store checks."
	| jumpSC |
	<option: #IMMUTABILITY>
	<var: #trampolineName type: #'char *'>
	<var: #jumpSC type: #'AbstractInstruction *'>
	<inline: false>
	cogit zeroOpcodeIndex.
	cogit CmpCq: 0 R: TempReg.
	jumpSC := cogit JumpZero: 0.
	
	"CannotAssignTo:, we restore the index."
	cogit SubCq: 1 R: TempReg.
	cogit
		compileTrampolineFor: #ceCannotAssignTo:withIndex:valueToAssign:
		numArgs: 3
		arg: ReceiverResultReg
		arg: TempReg
		arg: ClassReg
		arg: nil
		regsToSave: cogit emptyRegisterMask
		pushLinkReg: true
		resultReg: NoReg.
		
	"Store check"
	jumpSC jmpTarget: cogit Label.
	^ cogit genTrampolineFor: #remember:
		called: trampolineName
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: cogit emptyRegisterMask
		pushLinkReg: true
		resultReg: NoReg
		appendOpcodes: true