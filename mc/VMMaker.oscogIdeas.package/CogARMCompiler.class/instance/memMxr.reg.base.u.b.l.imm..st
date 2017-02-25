encoding
memMxr: cond reg: destReg  base: baseReg u: updown b: byteword l: loadstore imm: immediate12bitValue
"This is the lowest level build of an ARM [base +/- immediate 12bit offset] memory instruction
u -> up (1) or down (0) ie + or - for the offset
b -> byte(1) or word (0)
l -> load (1) or store (0)"

	^ (cond bitAnd: 16rF) << 28
		bitOr: (5<<24
		bitOr: ((updown bitAnd: 1) << 23
		bitOr:((byteword bitAnd: 1) <<22
		bitOr:((loadstore bitAnd: 1) <<20
		bitOr:((baseReg bitAnd: 16rF) <<16
		bitOr:((destReg bitAnd: 16rF) <<12
		bitOr: (immediate12bitValue bitAnd: 16rFFF)))))))