oop functions
digitDivLarge: firstInteger with: secondInteger negative: neg 
	"Does not normalize."
	"Division by zero has to be checked in caller."
	| firstDigitLen secondDigitLen quoDigitLen d div rem quo result |
	firstDigitLen := self digitSizeOfLargeInt: firstInteger.
	secondDigitLen := self digitSizeOfLargeInt: secondInteger.
	quoDigitLen := firstDigitLen - secondDigitLen + 1.
	quoDigitLen <= 0
		ifTrue: 
			[self remapOop: firstInteger in: [result := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2].
			interpreterProxy stObject: result at: 1 put: (0 asOop: SmallInteger).
			interpreterProxy stObject: result at: 2 put: firstInteger.
			^ result].
	"set rem and div to copies of firstInteger and secondInteger, respectively. 
	  However,  
	 to facilitate use of Knuth's algorithm, multiply rem and div by 2 (that 
	 is, shift)   
	 until the high word of div is >=16r80000000"
	d := 32 - (self cHighBit32: (self unsafeDigitOfLargeInt: secondInteger at: secondDigitLen)).
	self remapOop: firstInteger
		in: 
			[div := self digit: secondInteger Lshift: d.
			div := self largeInt: div growTo: (self digitSizeOfLargeInt: div) + 1 * 4].
	self remapOop: div
		in: 
			[rem := self digit: firstInteger Lshift: d.
			(self digitSizeOfLargeInt: rem) = firstDigitLen
				ifTrue: [rem := self largeInt: rem growTo: firstDigitLen + 1 * 4]].
	self remapOop: #(div rem ) in: [quo := self createLargeIntegerNeg: neg digitLength: quoDigitLen].
	self
		cDigitDiv: (self pointerToFirstDigitOfLargeInt: div)
		len: (self digitSizeOfLargeInt: div)
		rem: (self pointerToFirstDigitOfLargeInt: rem)
		len: (self digitSizeOfLargeInt: rem)
		quo: (self pointerToFirstDigitOfLargeInt: quo)
		len: (self digitSizeOfLargeInt: quo).
	self remapOop: #(quo ) in: [rem := self
					digit: rem
					Rshift: d
					lookfirst: (self digitSizeOfLargeInt: div)
							- 1].
	"^ Array with: quo with: rem"
	self remapOop: #(quo rem ) in: [result := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2].
	interpreterProxy stObject: result at: 1 put: quo.
	interpreterProxy stObject: result at: 2 put: rem.
	^ result