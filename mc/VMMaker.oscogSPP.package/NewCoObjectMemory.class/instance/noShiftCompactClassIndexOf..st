cog jit support
noShiftCompactClassIndexOf: oop
	<api>
	^(self baseHeader: oop) bitAnd: 16r1F << self compactClassFieldLSB