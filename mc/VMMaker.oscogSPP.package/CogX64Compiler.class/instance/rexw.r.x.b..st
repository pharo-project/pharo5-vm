encoding
rexw: width64 "<Boolean>" r: reg "<0-15>" x: sibReg "<0-15>"  b: fieldReg "<0-15>"
	"Given width64, the R register, sib register, and modrm/sib/reg field register,
	 answer the correctly encoded REX prefix byte.
	 See AMD64 Architecture Programmer's Manual Volume 3: General-Purpose and System Instructions, Table 1-11"
	| regBits |
	regBits := ((reg bitAnd: 8) >> 1) + ((sibReg bitAnd: 8) >> 2) + (fieldReg >> 3).
	^(width64 ifTrue: [16r48] ifFalse: [16r40]) + regBits