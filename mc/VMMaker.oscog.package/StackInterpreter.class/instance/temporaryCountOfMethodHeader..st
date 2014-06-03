compiled methods
temporaryCountOfMethodHeader: header
	<api>
	<inline: true>
	^(header >> 19) bitAnd: 16r3F