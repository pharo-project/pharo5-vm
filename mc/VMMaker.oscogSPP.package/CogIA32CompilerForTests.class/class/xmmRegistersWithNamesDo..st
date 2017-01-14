test support
xmmRegistersWithNamesDo: aBinaryBlock
	{XMM0L. XMM1L. XMM2L. XMM3L. XMM4L. XMM5L. XMM6L. XMM7L}
		with: #('%xmm0' '%xmm1' '%xmm2' '%xmm3' '%xmm4' '%xmm5' '%xmm6' '%xmm7')
		do: aBinaryBlock