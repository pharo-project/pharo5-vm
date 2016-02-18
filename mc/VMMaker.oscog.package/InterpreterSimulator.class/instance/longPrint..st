debug support
longPrint: oop
	| lastPtr val lastLong hdrType prevVal |
	(self isIntegerObject: oop) ifTrue: [^ self shortPrint: oop].
	^ String streamContents:
		[:strm |
		lastPtr := 64*self wordSize min: (self lastPointerOf: oop).
		hdrType := self headerType: oop.
		hdrType = 2 ifTrue: [lastPtr := 0].
		prevVal := 0.
		(self headerStart: oop) to: lastPtr by: self wordSize do:
			[:a | val := self longAt: oop+a.
			(a > 0 and: [(val = prevVal) & (a ~= lastPtr)])
			ifTrue:
			[prevVal = (self longAt: oop+a-(self wordSize*2)) ifFalse: [strm cr; nextPutAll: '        ...etc...']]
			ifFalse:
			[strm cr; nextPutAll: (a<16 ifTrue: [' ', a hex] ifFalse: [a hex]); 
				space; space; space; nextPutAll: val hex8; space; space.
			a = (self wordSize*2) negated ifTrue:
				[strm nextPutAll: 'size = ' , (val - hdrType) hex].
			a = self wordSize negated ifTrue:
				[strm nextPutAll: '<' , (self nameOfClass: (val - hdrType)) , '>'].
			a = 0 ifTrue: [strm cr; tab; nextPutAll: (self dumpHeader: val)].
			a > 0 ifTrue: [strm nextPutAll: (self shortPrint: val)].
			a = self wordSize ifTrue:
				[(self isCompiledMethod: oop) ifTrue:
					[strm cr; tab; nextPutAll: (self dumpMethodHeader: val)]]].
			prevVal := val].
		lastLong := 256 min: (self sizeBitsOf: oop) - self baseHeaderSize.
		hdrType = 2
			ifTrue:
			["free" strm cr; nextPutAll: (oop+(self longAt: oop)-2) hex;
			space; space; nextPutAll: (oop+(self longAt: oop)-2) printString]
			ifFalse:
			[(self formatOf: oop) = 3
			ifTrue:
				[strm cr; tab; nextPutAll: '/ next 3 fields are above SP... /'.
				lastPtr+self wordSize to: lastPtr+(3*self wordSize) by: self wordSize do:
					[:a | val := self longAt: oop+a.
					strm cr; nextPutAll: a hex; 
						space; space; space; nextPutAll: val hex8; space; space.
					(self validOop: val) ifTrue: [strm nextPutAll: (self shortPrint: val)]]]
			ifFalse:
			[lastPtr+self wordSize to: lastLong by: self wordSize do:
				[:a | val := self longAt: oop+a.
				strm cr; nextPutAll: (a<16 ifTrue: [' ', a hex] ifFalse: [a hex]); 
					space; space; space.
				strm nextPutAll: val hex8; space; space;
						nextPutAll: (self charsOfLong: val)]]].
	]