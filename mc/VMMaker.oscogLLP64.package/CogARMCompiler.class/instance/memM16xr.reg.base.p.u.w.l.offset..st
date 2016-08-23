encoding
memM16xr: cond reg: destReg base: baseReg p: postpreoffset u: updown w: weirdstuff l: loadstore offset: offset8 
	"build an ARM [base +/- offset8]  half-word memory instruction
	p -> pre-index (1) or post-index (0) the offset. Combines with W to do some odd things.
	u -> up (1) or down (0) ie + or - for the offset
	b -> byte(1) or word (0)
	w -> write-back (1) if pre-indexing. 
	l -> load (1) or store (0)"
	^ cond << 28
		bitOr: (0 << 25
		bitOr: (postpreoffset << 24
		bitOr: (updown << 23
		bitOr: (1 << 22
		bitOr: (weirdstuff << 21
		bitOr: (loadstore << 20
		bitOr: (baseReg << 16
		bitOr: (destReg << 12 
		bitOr: ((offset8 bitAnd: 16rF0) << 4
		bitOr: (11 << 4
		bitOr: (offset8 bitAnd: 16rF)))))))))))