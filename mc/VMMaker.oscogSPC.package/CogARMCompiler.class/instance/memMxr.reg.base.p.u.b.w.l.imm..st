encoding
memMxr: cond reg: destReg base: baseReg p: postpreoffset u: updown b: byteword w: weirdstuff l: loadstore imm: offset
	"build an ARM [base +/- offset] memory instruction
	p -> pre-index (1) or post-index (0) the offset. Combines with W to do some odd things.
	u -> up (1) or down (0) ie + or - for the offset
	b -> byte(1) or word (0)
	w -> write-back (1) if pre-indexing. 
	l -> load (1) or store (0)"
	^ cond << 28
		bitOr: (2 << 25
		bitOr: (postpreoffset << 24
		bitOr: (updown << 23
		bitOr: (byteword << 22
		bitOr: (weirdstuff << 21
		bitOr: (loadstore << 20
		bitOr: (baseReg << 16
		bitOr: (destReg << 12 bitOr: offset))))))))