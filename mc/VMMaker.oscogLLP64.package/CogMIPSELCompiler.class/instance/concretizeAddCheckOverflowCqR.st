generate machine code - concretize
concretizeAddCheckOverflowCqR
	| destReg leftReg rightImm |
	rightImm := operands at: 0.
	destReg := leftReg := operands at: 1.

	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: rightImm)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: rightImm)).

	"Save original LHS"
	self machineCodeAt: 8 put: (self adduR: OverflowTemp1 R: leftReg R: ZR). 
	
	"The actual addition"
	self machineCodeAt: 12 put: (self adduR: destReg R: leftReg R: AT). 

	"Set sign bit of OverflowTemp2 if sign of result differs from sign of RHS."
	self machineCodeAt: 16 put: (self xorR: OverflowTemp2 R: destReg R: AT).
	"Set sign bit of OverflowTemp1 if sign of result differs from sign of LHS."
	self machineCodeAt: 20 put: (self xorR: OverflowTemp1 R: destReg R: OverflowTemp1).
	"Set sign bit of Overflow if sign of result differs from both LHS and RHS, which indicates overflow."
	self machineCodeAt: 24 put: (self andR: Overflow R: OverflowTemp1 R: OverflowTemp2).
	^machineCodeSize := 28