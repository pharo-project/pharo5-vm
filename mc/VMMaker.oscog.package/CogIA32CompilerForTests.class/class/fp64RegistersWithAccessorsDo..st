test support
fp64RegistersWithAccessorsDo: aTrinaryBlock
	self fp64registers withIndexDo:
		[:reg :i|
		aTrinaryBlock
			value: reg
			value: (#(xmm0low xmm1low xmm2low xmm3low xmm4low xmm5low xmm6low xmm7low) at: i)
			value: (#(xmm0low: xmm1low: xmm2low: xmm3low: xmm4low: xmm5low: xmm6low: xmm7low:) at: i)]