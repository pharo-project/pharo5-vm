debug support
dumpMethodHeader: hdr
	^ String streamContents:
		[:strm |
		strm nextPutAll: '<nArgs=', ((hdr >> 25) bitAnd: 16r1F) printString , '>'.
		strm nextPutAll: '<nTemps=', ((hdr >> 19) bitAnd: 16r3F) printString , '>'.
		strm nextPutAll: '<lgCtxt=', ((hdr >> 18) bitAnd: 16r1) printString , '>'.
		strm nextPutAll: '<nLits=', ((hdr >> 10) bitAnd: 16rFF) printString , '>'.
		strm nextPutAll: '<prim=', ((hdr >> 1) bitAnd: 16r1FF) printString , '>'.
		]