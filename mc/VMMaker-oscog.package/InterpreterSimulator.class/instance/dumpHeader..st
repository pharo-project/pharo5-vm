debug support
dumpHeader: hdr
	| cc |
	^ String streamContents: [:strm |
		cc := (hdr bitAnd: CompactClassMask) >> 12.
		strm nextPutAll: '<cc=', cc hex.
		cc > 0 ifTrue:
			[strm nextPutAll: ':' , (self nameOfClass: (self compactClassAt: cc))].
		strm nextPutAll: '>'.
		strm nextPutAll: '<ft=', ((hdr bitShift: -8) bitAnd: 16rF) hex , '>'.
		strm nextPutAll: '<sz=', (hdr bitAnd: SizeMask) hex , '>'.
		strm nextPutAll: '<hdr=', (#(big class gcMark short) at: (hdr bitAnd: 3) +1) , '>']
