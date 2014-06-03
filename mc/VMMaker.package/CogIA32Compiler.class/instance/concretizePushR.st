generate machine code
concretizePushR
	<inline: true>
	machineCode at: 0 put: 16r50 + (self concreteRegister: (operands at: 0)).
	^machineCodeSize := 1