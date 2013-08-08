header access
compactClassIndexOfHeader: header
	<api>
	<inline: true>
	^(header >> 12) bitAnd: 16r1F