encoding
cond: c bx: link target: targetReg
	"c : 4 bit, opcode = 10 bitOr: link, offset >>2, limited to 24 bits (which are sign-extended, shifted left 2 and added to 8 + pc to make the resulting address)"
	"BX targetReg or BLX targetReg"
	<inline: true>
	^ c << 28 bitOr: ( (16r12FFF10  bitOr: (link bitAnd: 1) <<5 ) bitOr: targetReg)