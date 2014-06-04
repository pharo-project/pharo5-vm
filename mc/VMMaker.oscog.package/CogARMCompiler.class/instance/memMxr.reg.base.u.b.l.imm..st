encoding
memMxr: cond reg: destReg  base: baseReg u: updown b: byteword l: loadstore imm: immediate12bitValue
"build an ARM [base +/- immediate 12bit offset] memory instruction
u -> up (1) or down (0) ie + or - for the offset
b -> byte(1) or word (0)
l -> load (1) or store (0)"

	^ cond << 28
		bitOr: (5<<24
		bitOr: (updown << 23
		bitOr:(byteword<<22
		bitOr:(loadstore<<20
		bitOr:(baseReg<<16
		bitOr:(destReg<<12
		bitOr: immediate12bitValue))))))