instructions - arithmetic
divideSigned: instruction
	"Strangely, the MIPS reference manual does not indicate which division is used, but testing some hardware show it is truncated division (rather than floored division or Euclidean division)."	
	| rsValue rtValue |
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	lo := rsValue quo: rtValue.
	hi := rsValue rem: rtValue.
