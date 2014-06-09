test support
dataRegistersWithAccessorsDo: aTrinaryBlock
	"r0 ... sp. We can't use pc or RISCTempReg, because some opcodes may be encoded as multiple instructions and this, we need to be able to step."
	#(0 1 2 3 4 5 6 7 8 9 11 12 13 14) withIndexDo:
		[:reg :i|
		aTrinaryBlock
			value: reg
			value: (#(r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 fp r12 sp lr) at: i)
			value: (#(r0: r1: r2: r3: r4: r5: r6: r7: r8: r9: fp: r12: sp: lr:) at: i)]