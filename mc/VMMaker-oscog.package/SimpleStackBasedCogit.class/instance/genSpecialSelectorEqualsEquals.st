bytecode generators
genSpecialSelectorEqualsEquals
	| jumpNotEqual jumpPush |
	<var: #jumpNotEqual type: #'AbstractInstruction *'>
	<var: #jumpPush type: #'AbstractInstruction *'>
	self PopR: TempReg.
	self MoveMw: 0 r: SPReg R: ClassReg.
	self CmpR: TempReg R: ClassReg.
	jumpNotEqual := self JumpNonZero: 0.
	self annotate: (self MoveCw: objectMemory trueObject R: TempReg)
		objRef: objectMemory trueObject.
	jumpPush := self Jump: 0.
	jumpNotEqual jmpTarget: (self annotate: (self MoveCw: objectMemory falseObject R: TempReg)
							objRef: objectMemory falseObject).
	jumpPush jmpTarget: (self MoveR: TempReg Mw: 0 r: SPReg).
	^0