bytecode generators
genSpecialSelectorEqualsEquals
	| jumpNotEqual jumpPush |
	<var: #jumpNotEqual type: #'AbstractInstruction *'>
	<var: #jumpPush type: #'AbstractInstruction *'>
	self PopR: Arg0Reg.
	objectRepresentation
		genEnsureObjInRegNotForwarded: Arg0Reg
		scratchReg: TempReg.
	self MoveMw: 0 r: SPReg R: ClassReg.
	objectRepresentation
		genEnsureObjInRegNotForwarded: ClassReg
		scratchReg: TempReg.
	self CmpR: Arg0Reg R: ClassReg.
	jumpNotEqual := self JumpNonZero: 0.
	self annotate: (self MoveCw: objectMemory trueObject R: Arg0Reg)
		objRef: objectMemory trueObject.
	jumpPush := self Jump: 0.
	jumpNotEqual jmpTarget: (self annotate: (self MoveCw: objectMemory falseObject R: Arg0Reg)
							objRef: objectMemory falseObject).
	jumpPush jmpTarget: (self MoveR: Arg0Reg Mw: 0 r: SPReg).
	^0