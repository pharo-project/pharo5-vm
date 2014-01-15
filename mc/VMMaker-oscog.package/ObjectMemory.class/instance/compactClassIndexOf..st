header access
compactClassIndexOf: oop
	<inline: true>
	^((self baseHeader: oop) >> 12) bitAnd: 16r1F