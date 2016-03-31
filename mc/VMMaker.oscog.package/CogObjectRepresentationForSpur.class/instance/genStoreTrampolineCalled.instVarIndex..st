initialization
genStoreTrampolineCalled: trampolineName instVarIndex: instVarIndex
	"Convention:
	- RcvrResultReg holds the object mutated.
	If immutability failure:
	- TempReg holds the instance variable index mutated 
		if instVarIndex > numDedicatedStoreTrampoline
	- ClassReg holds the value to store
	Registers are not lived across this trampoline as the 
	immutability failure may need new stack frames."
	
	| jumpSC |
	<option: #IMMUTABILITY>
	<var: #trampolineName type: #'char *'>
	<var: #jumpSC type: #'AbstractInstruction *'>
	<inline: false>
	cogit zeroOpcodeIndex.
	jumpSC := self genJumpMutable: ReceiverResultReg scratchReg: SendNumArgsReg. "SendNumArgsReg is mutated but we don't care as register are not live across the trampoline"
	instVarIndex = self numStoreTrampolines
		ifFalse: [ cogit MoveCq: instVarIndex R: TempReg ]. 
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