compile abstract instructions
compileGetErrorCode
	"After pushing the temporaries but before the stack limit check a primitive method
	 needs to fetch the error code, if any, and replace the last temp with it."
	<inline: false>
	| jmpNoError primErrorTable primErrorTableSize jmpIntError jmpGotError |
	<var: #jmpNoError type: #'AbstractInstruction *'>
	<var: #jmpIntError type: #'AbstractInstruction *'>
	<var: #jmpGotError type: #'AbstractInstruction *'>
	self MoveAw: coInterpreter primFailCodeAddress R: TempReg.
	self flag: 'ask concrete code gen if move sets condition codes?'.
	self CmpCq: 0 R: TempReg.
	jmpNoError := self JumpZero: 0.
	primErrorTable := coInterpreter primErrTable.
	primErrorTableSize := objectMemory lengthOf: primErrorTable.
	self flag: 'use CmpCqR if pc mapping means stable contexts never contain native pcs'.
	"Can't use CmpCqR here because table could change its size.
	 Assume generated code is flushed whenever primitive error table is changed."
	self CmpCw: primErrorTableSize R: TempReg.
	jmpIntError := self JumpAboveOrEqual: 0. "Filter out negative values as well"
	objectRepresentation genFetchIndexRegister: TempReg from: primErrorTable into: ClassReg.
	jmpGotError := self Jump: 0.
	jmpIntError jmpTarget: self Label.
	objectRepresentation genConvertIntegerToSmallIntegerInReg: TempReg.
	self MoveR: TempReg R: ClassReg.
	jmpGotError jmpTarget: (self MoveR: ClassReg Mw: 0 r: SPReg).
	"zero the error code to agree with the interpreter's (internal)ActivateNewMethod."
	self MoveCq: 0 R: TempReg.
	self MoveR: TempReg Aw: coInterpreter primFailCodeAddress.
	jmpNoError jmpTarget: self Label