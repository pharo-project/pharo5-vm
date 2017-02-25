test support
byteRegistersWithNamesDo: aBinaryBlock
	(self registers first: 4)
		with: #('%al' '%cl' '%dl' '%bl')
		do: aBinaryBlock