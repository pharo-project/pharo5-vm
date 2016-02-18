encoding
cond: c type: t op: o set: s
	"c : 4 bit, t: 3 bit, o: 4 bit, s: 1bit"
	"cccctttoooos + oxFFFFF - the leftmost 12bits of (most) ARM instruction. The other 20 bits get built elsewhere"
	<inline: true>
	^ c << 28 bitOr: ((t << 25) bitOr: ((o << 21) bitOr: (s << 20)))