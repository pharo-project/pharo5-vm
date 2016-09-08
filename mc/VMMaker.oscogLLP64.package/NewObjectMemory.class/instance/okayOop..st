debug support
okayOop: signedOop
	"Verify that the given oop is legitimate. Check address, header, and size but not class."

	| sz type fmt unusedBit oop |
	<var: #oop type: #usqInt>
	oop := self cCoerce: signedOop to: #usqInt.

	"address and size checks"
	(self isIntegerObject: oop) ifTrue: [ ^true ].
	(oop >= self startOfMemory and: [oop < freeStart])
		ifFalse: [ self error: 'oop is not a valid address'. ^false ].
	((oop \\ self wordSize) = 0)
		ifFalse: [ self error: 'oop is not a word-aligned address'. ^false ].
	sz := self sizeBitsOf: oop.
	(oop + sz) <= freeStart
		ifFalse: [ self error: 'oop size would make it extend beyond the end of memory'. ^false ].

	"header type checks"
	type := self headerType: oop.
	type = HeaderTypeFree
		ifTrue:  [ self error: 'oop is a free chunk, not an object'. ^false ].
	type = HeaderTypeShort ifTrue: [
		(self compactClassIndexOf: oop) = 0
			ifTrue:  [ self error: 'cannot have zero compact class field in a short header'. ^false ].
	].
	type = HeaderTypeClass ifTrue: [
		((oop >= self wordSize) and: [(self headerType: oop - self wordSize) = type])
			ifFalse: [ self error: 'class header word has wrong type'. ^false ].
	].
	type = HeaderTypeSizeAndClass ifTrue: [
		((oop >= (self wordSize*2)) and:
		 [(self headerType: oop - (self wordSize*2)) = type and:
		 [(self headerType: oop - self wordSize) = type]])
			ifFalse: [ self error: 'class header word has wrong type'. ^false ].
	].

	"format check"
	fmt := self formatOf: oop.
	((fmt = 5) | (fmt = 7))
		ifTrue:  [ self error: 'oop has an unknown format type'. ^false ].

	"mark and root bit checks"
	unusedBit := 16r20000000.
	self wordSize = 8
		ifTrue:
			[unusedBit := unusedBit << 16.
			 unusedBit := unusedBit << 16].
	((self longAt: oop) bitAnd: unusedBit) = 0
		ifFalse: [ self error: 'unused header bit 30 is set; should be zero'. ^false ].
"xxx
	((self longAt: oop) bitAnd: MarkBit) = 0
		ifFalse: [ self error: 'mark bit should not be set except during GC' ].
xxx"
	((self isYoungRoot: oop) and: [oop >= youngStart])
		ifTrue: [ self error: 'root bit is set in a young object'. ^false ].
	^true
