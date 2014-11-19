compiled methods
temporaryCountOfMethodHeader: header
	<api>
	<inline: true>
	^header >> MethodHeaderTempCountShift bitAnd: 16r3F