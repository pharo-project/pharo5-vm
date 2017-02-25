header access
compactClassIndexOfHeader: header
	<api>
	<inline: true>
	^(header >> self compactClassFieldLSB) bitAnd: 16r1F