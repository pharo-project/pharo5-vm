accessing
roundUpLength: numBytes
	<cmacro: '(numBytes) ((numBytes) + 7 & -8)'>
	^numBytes + 7 bitAnd: -8