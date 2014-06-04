encoding
cond: c br: link offset: offset
	"c : 4 bit, opcode = 10 bitOr: link, offset >>2, limited to 24 bits (which are sign-extended, shifted left 2 and added to 8 + pc to make the resulting address)"
	"single instr Branch, no link"
	<inline: true>
	^ c << 28 bitOr: (((2r1010 bitOr: (link bitAnd: 1)) << 24) bitOr: (offset >> 2 bitAnd: 16r00FFFFFF))