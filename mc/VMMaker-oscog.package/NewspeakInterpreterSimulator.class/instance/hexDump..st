debug support
hexDump: oop
	| byteSize val |
	(self isIntegerObject: oop) ifTrue: [^ self shortPrint: oop].
	^ String streamContents:
		[:strm |
		byteSize := 256 min: (self sizeBitsOf: oop)-4.
		(self headerStart: oop) to: byteSize by: 4 do:
			[:a | val := self longAt: oop+a.
			strm cr; nextPutAll: (a<16 ifTrue: [' ', a hex] ifFalse: [a hex]); 
				space; space; space; nextPutAll: val hex8;
				space; space.
			a=0
				ifTrue: [strm nextPutAll: (self dumpHeader: val)]
				ifFalse: [strm nextPutAll: (self charsOfLong: val)]]]