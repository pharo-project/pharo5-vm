generate machine code - concretize
concretizeCmpCwR
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	self flag: #todo. "value - reg or reg - value?"
	self flag: #inefficient. "Cog RTL assumes we can do any kind of conditional branch after a Cmp."
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: value)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: value)).
	self machineCodeAt: 8 put: (self subuR: Cmp R: reg R: AT).
	self machineCodeAt: 12 put: (self sltR: CmpSLT R: reg R: AT).
	self machineCodeAt: 16 put: (self sltR: CmpSGT R: AT R: reg).
	self machineCodeAt: 20 put: (self sltuR: CmpULT R: reg R: AT).
	self machineCodeAt: 24 put: (self sltuR: CmpUGT R: AT R: reg).
	^machineCodeSize := 28