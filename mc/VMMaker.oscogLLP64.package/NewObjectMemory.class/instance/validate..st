simulation
validate: oop
	<doNotGenerate>
	| header type cc sz fmt nextChunk | 
	header := self longAt: oop.
	type := header bitAnd: 3.
	type = 2 ifFalse: [type = (self rightType: header) ifFalse: [self halt]].
	sz := (header bitAnd: SizeMask) >> 2.
	nextChunk := oop + ((self isFreeObject: oop)
							ifTrue: [self sizeOfFree: oop]
							ifFalse: [self sizeBitsOf: oop]).
	nextChunk >= freeStart
		ifTrue:
			[nextChunk ~= freeStart ifTrue: [self halt]]
		ifFalse:
			[(self headerType: nextChunk) = 0 ifTrue:
				[(self headerType: (nextChunk + (self wordSize*2))) = 0 ifFalse: [self halt]].
			(self headerType: nextChunk) = 1 ifTrue:
				[(self headerType: (nextChunk + self wordSize)) = 1 ifFalse: [self halt]]].
	type = 2 ifTrue: "free block"
		[^self].
	fmt := self formatOfHeader: header.
	cc := self compactClassIndexOfHeader: header.
	cc > 16 ifTrue: [self halt].	"up to 32 are legal, but not used"
	type = 0 ifTrue:
		["three-word header"
		((self longAt: oop-self wordSize) bitAnd: 3) = type ifFalse: [self halt].
		((self longAt: oop-(self wordSize*2)) bitAnd: 3) = type ifFalse: [self halt].
		((self longAt: oop-self wordSize) = type) ifTrue: [self halt].	"Class word is 0"
		sz = 0 ifFalse: [self halt]].
	type = 1 ifTrue:
		["two-word header"
		((self longAt: oop-self wordSize) bitAnd: 3) = type ifFalse: [self halt].
		cc > 0 ifTrue: [sz = 1 ifFalse: [self halt]].
		sz = 0 ifTrue: [self halt]].
	type = 3 ifTrue:
		["one-word header"
		cc = 0 ifTrue: [self halt]].
	fmt = 5 ifTrue: [self halt].
	fmt = 7 ifTrue: [self halt].
	fmt >= self firstCompiledMethodFormat ifTrue: "must have integer header"
		[(self isIntegerObject: (self longAt: oop + self wordSize)) ifFalse: [self halt]].