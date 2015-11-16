generate machine code - concretize
concretizeAndCwR
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: value)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: value)).
	self machineCodeAt: 8 put: (self andR: reg R: reg R: AT).
	self flag: #inefficient. "Cog RTL assumes we can do any kind of conditional branch after a Cmp."
	self machineCodeAt: 12 put: (self andR: Cmp R: reg R: AT).
	^machineCodeSize := 16