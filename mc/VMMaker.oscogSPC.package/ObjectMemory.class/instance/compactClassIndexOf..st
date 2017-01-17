object access
compactClassIndexOf: oop
	<api>
	<inline: true>
	^((self baseHeader: oop) >> self compactClassFieldLSB) bitAnd: 16r1F