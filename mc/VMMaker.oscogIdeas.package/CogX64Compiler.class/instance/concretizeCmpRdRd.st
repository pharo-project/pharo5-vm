generate machine code
concretizeCmpRdRd
	"Will get inlined into concretizeAt: switch.
	 We use UCOMISD (see p 4-260 [2])"
	<inline: true>
	| regLHS regRHS skip |
	"CmpRR RHS LHS computes LHS - RHS, i.e. apparently reversed.  You have to think subtract."
	regRHS := operands at: 0.
	regLHS := operands at: 1.
	
	machineCode
		at: 0 put: 16r66.
	(regLHS <= 7 and: [regRHS <= 7])
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: regLHS x: 0 b: regRHS)].	
	
	machineCode
		at: skip + 1 put: 16r0F;
		at: skip + 2 put: 16r2E;
		at: skip + 3 put: (self mod: ModReg RM: regRHS RO: regLHS).
	^machineCodeSize := skip + 4