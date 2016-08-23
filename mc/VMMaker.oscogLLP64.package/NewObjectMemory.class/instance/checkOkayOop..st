debug support
checkOkayOop: oop
	"Verify that the given oop is legitimate. Check address, header, and size but not class.
	 Answer true if OK.  Otherwise print reason and answer false."

	<api>
	<var: #oop type: #usqInt>
	| sz type fmt unusedBit |

	"address and size checks"
	(self isIntegerObject: oop) ifTrue: [ ^true ].
	((self oop: oop isGreaterThanOrEqualTo: self startOfMemory) and: [self oop: oop isLessThan: freeStart])
		ifFalse: [ self print: 'oop '; printHex: oop; print: ' is not a valid address'; cr. ^false ].
	((oop \\ self wordSize) = 0)
		ifFalse: [ self print: 'oop '; printHex: oop; print: ' is not a word-aligned address'; cr. ^false ].
	sz := self sizeBitsOf: oop.
	(self oop: oop + sz isLessThanOrEqualTo: freeStart)
		ifFalse: [ self print: 'oop '; printHex: oop; print: ' size would make it extend beyond the end of memory'; cr. ^false ].

	"header type checks"
	type := self headerType: oop.
	type = HeaderTypeFree
		ifTrue:  [ self print: 'oop '; printHex: oop; print: ' is a free chunk, not an object'; cr. ^false ].
	type = HeaderTypeShort ifTrue: [
		(self compactClassIndexOf: oop) = 0
			ifTrue:  [ self print: 'oop '; printHex: oop; print: ' cannot have zero compact class field in a short header'; cr. ^false ].
	].
	type = HeaderTypeClass ifTrue: [
		((oop >= self wordSize) and: [(self headerType: oop - self wordSize) = type])
			ifFalse: [ self print: 'oop '; printHex: oop; print: ' class header word has wrong type'; cr. ^false ].
	].
	type = HeaderTypeSizeAndClass ifTrue: [
		((oop >= (self wordSize*2)) and:
		 [(self headerType: oop - (self wordSize*2)) = type and:
		 [(self headerType: oop - self wordSize) = type]])
			ifFalse: [ self print: 'oop '; printHex: oop; print: ' class header word has wrong type'; cr. ^false ].
	].

	"format check"
	fmt := self formatOf: oop.
	((fmt = 5) | (fmt = 7))
		ifTrue:  [ self print: 'oop '; printHex: oop; print: ' has an unknown format type'; cr. ^false ].

	"mark and root bit checks"
	unusedBit := 16r20000000.
	self wordSize = 8
		ifTrue:
			[unusedBit := unusedBit << 16.
			 unusedBit := unusedBit << 16].
	((self longAt: oop) bitAnd: unusedBit) = 0
		ifFalse: [ self print: 'oop '; printHex: oop; print: ' unused header bit 30 is set; should be zero'; cr. ^false ].
"xxx
	((self longAt: oop) bitAnd: MarkBit) = 0
		ifFalse: [ self print: 'mark bit should not be set except during GC' ].
xxx"
	((self isYoungRoot: oop) and: [oop >= youngStart])
		ifTrue: [ self print: 'oop '; printHex: oop; print: ' root bit is set in a young object'; cr. ^false ].
	^true
