oop functions
digitDivLarge: firstInteger with: secondInteger negative: neg 
	"Does not normalize."
	"Division by zero has to be checked in caller."
	| firstLen secondLen resultClass l d div rem quo result |
	firstLen := self byteSizeOfBytes: firstInteger.
	secondLen := self byteSizeOfBytes: secondInteger.
	neg
		ifTrue: [resultClass := interpreterProxy classLargeNegativeInteger]
		ifFalse: [resultClass := interpreterProxy classLargePositiveInteger].
	l := firstLen - secondLen + 1.
	l <= 0
		ifTrue: 
			[self remapOop: firstInteger in: [result := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2].
			result stAt: 1 put: (0 asOop: SmallInteger).
			result stAt: 2 put: firstInteger.
			^ result].
	"set rem and div to copies of firstInteger and secondInteger, respectively. 
	  However,  
	 to facilitate use of Knuth's algorithm, multiply rem and div by 2 (that 
	 is, shift)   
	 until the high byte of div is >=128"
	d := 8 - (self cHighBit: (self unsafeByteOf: secondInteger at: secondLen)).
	self remapOop: firstInteger
		in: 
			[div := self bytes: secondInteger Lshift: d.
			div := self bytesOrInt: div growTo: (self digitLength: div)
							+ 1].
	self remapOop: div
		in: 
			[rem := self bytes: firstInteger Lshift: d.
			(self digitLength: rem)
				= firstLen ifTrue: [rem := self bytesOrInt: rem growTo: firstLen + 1]].
	self remapOop: #(div rem ) in: [quo := interpreterProxy instantiateClass: resultClass indexableSize: l].
	self
		cCoreDigitDivDiv: (interpreterProxy firstIndexableField: div)
		len: (self digitLength: div)
		rem: (interpreterProxy firstIndexableField: rem)
		len: (self digitLength: rem)
		quo: (interpreterProxy firstIndexableField: quo)
		len: (self digitLength: quo).
	self remapOop: #(quo ) in: [rem := self
					bytes: rem
					Rshift: d
					bytes: 0
					lookfirst: (self digitLength: div)
							- 1].
	"^ Array with: quo with: rem"
	self remapOop: #(quo rem ) in: [result := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2].
	result stAt: 1 put: quo.
	result stAt: 2 put: rem.
	^ result