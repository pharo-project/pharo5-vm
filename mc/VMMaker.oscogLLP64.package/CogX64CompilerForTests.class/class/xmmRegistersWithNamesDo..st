test support
xmmRegistersWithNamesDo: aBinaryBlock
	(XMM0L to: XMM15L by: XMM1L - XMM0L)
		with: ((0 to: 15) collect: [:i| '%xmm', i printString])
		do: aBinaryBlock