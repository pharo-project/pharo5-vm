tests
testMOVSD
	"Test MOVSD indirecting through edx."
	"self new testMOVSD"
	self processor
		edx: 0;
		eip: 0;
		singleStepIn: {16rF2. 16r0F. 16r10. 16r42. 16r04. 16r90. 16r01. 16r02. 16r03. 16r04. 16r05. 16r06} asByteArray "movsd %ds:0x4(%edx), %xmm0;nop;garbage".
	self assert: self processor eip = 5.
	self assert: self processor xmm0low = 16r0605040302019004