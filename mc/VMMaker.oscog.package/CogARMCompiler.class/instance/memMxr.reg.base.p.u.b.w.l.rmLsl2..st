encoding
memMxr: cond reg: destReg base: baseReg p: postpreoffset u: updown b: byteword w: weirdstuff l: loadstore rmLsl2: offsetReg 
	"build an ARM [base +/- offsetReg lsl #2] memory instruction - see also #memMxr:reg:base:p:u:b:w:l:rm: and keep them correlated properly
	p -> pre-index (1) or post-index (0) the offset. Combines with W to do some odd things.
	u -> up (1) or down (0) ie + or - for the offset
	b -> byte(1) or word (0)
	w -> write-back (1) if pre-indexing. 
	l -> load (1) or store (0)"
	^ (cond bitAnd: 16rF)  << 28
		bitOr: (3 << 25
		bitOr: ((postpreoffset  bitAnd: 1) << 24
		bitOr: ((updown bitAnd: 1) << 23
		bitOr: ((byteword bitAnd: 1) << 22
		bitOr: ((weirdstuff bitAnd: 1) << 21
		bitOr: ((loadstore bitAnd: 1) << 20
		bitOr: ((baseReg bitAnd: 16rF) << 16
		bitOr: ((destReg bitAnd: 16rF) << 12
		bitOr: (16r100
		bitOr: (offsetReg bitAnd: 16rF))))))))))