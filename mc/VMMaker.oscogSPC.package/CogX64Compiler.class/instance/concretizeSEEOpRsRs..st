generate machine code
concretizeSEEOpRsRs: x64opcode
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| regLHS regRHS skip |
	regRHS := operands at: 0.
	regLHS := operands at: 1.
	machineCode
		at: 0 put: 16rF3.
	(regLHS <= 7 and: [regRHS <= 7])
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: regLHS x: 0 b: regRHS)].
	machineCode 
		at: skip + 1 put: 16r0F;
		at: skip + 2 put: x64opcode;
		at: skip + 3 put: (self mod: ModReg RM: regRHS RO: regLHS).
	^machineCodeSize := skip + 4