oop functions
bytes: aBytesOop Rshift: anInteger bytes: b lookfirst: a 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	"Shift right 8*b+anInteger bits, 0<=n<8.         
	Discard all digits beyond a, and all zeroes at or below a."
	"Does not normalize."
	| x f digit i oldLen newLen newBytes |
	x := 0.
	f := 8 - anInteger.
	i := a.
	digit := self digitOfBytes: aBytesOop at: i.
	[((digit >> anInteger)
		bitOr: x)
		= 0 and: [i ~= 1]]
		whileTrue: 
			[x := digit << f.
			"Can't exceed 8 bits"
			i := i - 1.
			digit := self digitOfBytes: aBytesOop at: i].
	i <= b ifTrue: [^ interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: aBytesOop)
			indexableSize: 0"Integer new: 0 neg: self negative"].
	"All bits lost"
	oldLen := self byteSizeOfBytes: aBytesOop.
	newLen := i - b.
	self remapOop: aBytesOop in: [newBytes := interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: aBytesOop)
					indexableSize: newLen].
	"r := Integer new: i - b neg: self negative."
	"	count := i.       
	"
	self
		cCoreBytesRshiftCount: i
		n: anInteger
		f: f
		bytes: b
		from: (interpreterProxy firstIndexableField: aBytesOop)
		len: oldLen
		to: (interpreterProxy firstIndexableField: newBytes)
		len: newLen.
	^ newBytes