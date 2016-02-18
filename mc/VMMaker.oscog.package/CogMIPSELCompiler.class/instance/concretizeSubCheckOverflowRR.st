generate machine code - concretize
concretizeSubCheckOverflowRR
	| destReg leftReg rightReg |
	rightReg := operands at: 0.
	destReg := leftReg := operands at: 1.

	"Save original LHS"
	self machineCodeAt: 0 put: (self adduR: OverflowTemp1 R: leftReg R: ZR). 
	
	"The actual subtraction"
	self machineCodeAt: 4 put: (self subuR: destReg R: leftReg R: rightReg). 

	"Set sign bit of OverflowTemp2 if sign of result differs from sign of RHS."
	self machineCodeAt: 8 put: (self xorR: OverflowTemp2 R: destReg R: rightReg).
	"Set sign bit of OverflowTemp1 if sign of result differs from sign of LHS."
	self machineCodeAt: 12 put: (self xorR: OverflowTemp1 R: destReg R: OverflowTemp1).
	"Set sign bit of Overflow if sign of result differs from both LHS and RHS, which indicates overflow."
	self machineCodeAt: 16 put: (self andR: Overflow R: OverflowTemp1 R: OverflowTemp2).
	^machineCodeSize := 20