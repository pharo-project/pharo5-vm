abstract instructions
genDivR: abstractRegDivisor R: abstractRegDividend Quo: abstractRegQuotient Rem: abstractRegRemainder
"Currently no instruction level support for divide on ARM. See also #canDivQuoRem"
	| rDividend rDivisor rQuotient rRemainder divRemFunctionAddr |
	<var: #divRemFunctionAddr type: #usqInt>
	self assert: abstractRegDividend ~= abstractRegDivisor.
	self assert: abstractRegQuotient ~= abstractRegRemainder.
	rDividend := abstractRegDividend.
	rDivisor := abstractRegDivisor.
	rDividend = CArg0Reg ifFalse:
		["we need to move the value in rDividend to CArg0Reg. Best to double check if rDivisor is already using it first"
		rDivisor = CArg0Reg ifTrue: "oh dear; we also need to move rDivisor's value out of the way first.. I'll move it to CArg1Reg and if some nitwit has managed to put rDividend there they deserve the crash"
			[rDividend = CArg1Reg ifTrue:
				[self error: 'register choices in genDivR:R:Quo:Rem: made life impossible'].
			cogit MoveR: rDivisor R: CArg1Reg.
			"and update rDivisor or we get buggerd by the next clause"
			rDivisor := CArg1Reg].
		cogit MoveR: rDividend R: CArg0Reg].
	rDivisor = CArg1Reg ifFalse:
		[cogit MoveR: rDivisor R: CArg1Reg].
	divRemFunctionAddr := self aeabiDivModFunctionAddr.
	cogit backEnd saveAndRestoreLinkRegAround:
		[cogit CallFullRT: (self cCode: [divRemFunctionAddr asUnsignedInteger]
							   inSmalltalk: [cogit simulatedTrampolineFor: divRemFunctionAddr])
			registersToBeSavedMask: (cogit registerMaskFor: CArg2Reg and: CArg3Reg)].
	"Now we need to move the r0/1 results back to rQuotient & rRemainder"
	rQuotient := abstractRegQuotient.
	rRemainder := abstractRegRemainder.
	rQuotient = CArg0Reg ifFalse: "oh good grief, not again"
		[cogit MoveR: CArg0Reg R: rQuotient.
		 rQuotient = CArg1Reg ifTrue:
			[self error: 'register choices in genDivR:R:Quo:Rem: made life impossible'] ].
	rRemainder = CArg1Reg  ifFalse:
		[cogit MoveR: CArg1Reg R: rRemainder]
				
