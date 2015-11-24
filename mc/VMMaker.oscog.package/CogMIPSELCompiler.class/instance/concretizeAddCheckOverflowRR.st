generate machine code - concretize
concretizeAddCheckOverflowRR
	| leftReg rightReg |
	leftReg := self concreteRegister: (operands at: 0).
	rightReg := self concreteRegister: (operands at: 1).

	"Save original RHS"
	self machineCodeAt: 0 put: (self adduR: OverflowTemp1 R: rightReg R: ZR). 
	
	"The actual addition"
	self machineCodeAt: 4 put: (self adduR: rightReg R: leftReg R: rightReg). 

	"Set sign bit of OverflowTemp2 if sign of result differs from sign of RHS."
	self machineCodeAt: 8 put: (self xorR: OverflowTemp2 R: rightReg R: leftReg).
	"Set sign bit of OverflowTemp1 if sign of result differs from sign of LHS."
	self machineCodeAt: 12 put: (self xorR: OverflowTemp1 R: rightReg R: OverflowTemp1).
	"Set sign bit of Overflow if sign of result differs from both LHS and RHS, which indicates overflow."
	self machineCodeAt: 16 put: (self andR: Overflow R: OverflowTemp1 R: OverflowTemp2).
	^machineCodeSize := 20