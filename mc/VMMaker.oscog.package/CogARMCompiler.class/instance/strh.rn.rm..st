ARM convenience instructions
strh: srcReg rn: baseReg rm: offsetReg
"	STRH srcReg, [baseReg, +offsetReg]"
	^self memM16xr: AL reg: srcReg base: baseReg p: 1 u: 1 w: 0 l: 0 rm: offsetReg