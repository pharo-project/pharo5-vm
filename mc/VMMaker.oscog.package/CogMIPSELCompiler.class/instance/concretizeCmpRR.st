generate machine code - concretize
concretizeCmpRR
	| leftReg rightReg |
	"CmpRR RHS LHS computes LHS - RHS, i.e. apparently reversed.  You have to think subtract."
	rightReg := self concreteRegister: (operands at: 0).
	leftReg := self concreteRegister: (operands at: 1).
	self flag: #inefficient. "Cog RTL assumes we can do any kind of conditional branch after a Cmp."
	self machineCodeAt: 0 put: (self subuR: Cmp R: leftReg R: rightReg).
	self machineCodeAt: 4 put: (self sltR: CmpSLT R: leftReg R: rightReg).
	self machineCodeAt: 8 put: (self sltR: CmpSGT R: rightReg R: leftReg).
	self machineCodeAt: 12 put: (self sltuR: CmpULT R: leftReg R: rightReg).
	self machineCodeAt: 16 put: (self sltuR: CmpUGT R: rightReg R: leftReg).
	^machineCodeSize := 20