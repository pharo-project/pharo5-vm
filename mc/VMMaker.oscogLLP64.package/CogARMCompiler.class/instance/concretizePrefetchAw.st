generate machine code - concretize
concretizePrefetchAw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand instrOffset|
	addressOperand := operands at: 0.
	(self isAddressRelativeToVarBase: addressOperand) ifTrue:
		[self machineCodeAt: 0 put: (self pld: ConcreteVarBaseReg plus: 1 offset: addressOperand - cogit varBaseAddress).
		 ^machineCodeSize := 4].
	instrOffset := self moveCw: addressOperand intoR: ConcreteIPReg.
	"pld	[ConcreteIPReg]"
	self machineCodeAt: instrOffset put: (self pld: ConcreteIPReg plus: 1offset: 0).
	^machineCodeSize := instrOffset + 4