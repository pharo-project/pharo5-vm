C code generator
cLiteralForUnsignedInteger: anInteger longlong: llBoolean
	"Answer the string for generating an unsigned literal integer.
	Eventually use hexadecimal.
	Force long long suffix (LL) if the integer does not fit on 32 bits, or if llBoolean is true."
	
	| hex |
	hex := (anInteger > 0
				and: [(anInteger >> anInteger lowBit + 1) isPowerOfTwo
				and: [(anInteger highBit = anInteger lowBit and: [anInteger > 65536])
					  or: [anInteger highBit - anInteger lowBit >= 4]]]).
	^self cLiteralForUnsignedInteger: anInteger hex: hex longlong: llBoolean