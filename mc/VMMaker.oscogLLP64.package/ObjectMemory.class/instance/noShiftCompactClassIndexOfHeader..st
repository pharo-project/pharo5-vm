header access
noShiftCompactClassIndexOfHeader: header
	<api>
	<inline: true>
	^header bitAnd: 16r1F << self compactClassFieldLSB