allocation
clone: obj
	"Return a shallow copy of the given object. May cause GC"
	"Assume: Oop is a real object, not a small integer."

	| extraHdrBytes bytes newChunk remappedOop fromIndex toIndex lastFrom newOop header hash |
	<inline: false>
	<var: #lastFrom type: #usqInt>
	<var: #fromIndex type: #usqInt>
	self assert: (self isNonIntegerObject: obj).
	extraHdrBytes := self extraHeaderBytes: obj.
	bytes := self sizeBitsOf: obj.
	bytes := bytes + extraHdrBytes.

	"allocate space for the copy, remapping obj in case of a GC"
	self pushRemappableOop: obj.
	"check it is safe to allocate this much memory. Return 0 if not"
	(self sufficientSpaceToAllocate: 2500 + bytes) ifFalse:[^0].
	newChunk := self allocateChunk: bytes.
	remappedOop := self popRemappableOop.

	"copy old to new including all header words"
	toIndex := newChunk - self wordSize.  "loop below uses pre-increment"
	fromIndex := (remappedOop - extraHdrBytes) - self wordSize.
	lastFrom := fromIndex + bytes.
	[fromIndex < lastFrom] whileTrue:
		[self longAt: (toIndex := toIndex + self wordSize) put: (self longAt: (fromIndex := fromIndex + self wordSize))].
	newOop := newChunk + extraHdrBytes.  "convert from chunk to oop"

	"fix base header: compute new hash and clear Mark and Root bits"
	hash := self newObjectHash.
	header := (self longAt: newOop) bitAnd: 16r1FFFF.
	"use old ccIndex, format, size, and header-type fields"
	header := header bitOr: ((hash << HashBitsOffset) bitAnd: HashBits).
	self longAt: newOop put: header.
	^newOop
