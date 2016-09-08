generate machine code - concretize
concretizePushCw
	| value |
	value := operands at: 0.
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: value)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: value)).
	self machineCodeAt: 8 put: (self addiuR: SP R: SP C: -4).
	self machineCodeAt: 12 put: (self swR: AT base: SP offset: 0).
	^machineCodeSize := 16