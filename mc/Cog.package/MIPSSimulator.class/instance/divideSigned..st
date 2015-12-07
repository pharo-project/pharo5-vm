instructions - arithmetic
divideSigned: instruction
	"Strangely, the MIPS reference manual does not indicate which division is used, but testing on some hardware shows it is truncated division (rather than floored division or Euclidean division)."	
	| rsValue rtValue |
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	rtValue = 0 ifTrue: 
		["No exception is signalled"
		 lo := rtValue. 
		 hi := rsValue.
		 ^self].
	(rtValue = -1 and: [rsValue = -16r80000000]) ifTrue:
		["Only overflow case"
		 lo := rsValue. 
		 hi := 0.
		 ^self].
	lo := rsValue quo: rtValue.
	hi := rsValue rem: rtValue.
