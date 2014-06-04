util
anyBitOfBytes: aBytesOop from: start to: stopArg 
	"Argument has to be aBytesOop!"
	"Tests for any magnitude bits in the interval from start to stopArg."
	| magnitude rightShift leftShift stop firstByteIx lastByteIx |
	self
		debugCode: [self msg: 'anyBitOfBytes: aBytesOop from: start to: stopArg'].
	start < 1 | (stopArg < 1)
		ifTrue: [^ interpreterProxy primitiveFail].
	magnitude := aBytesOop.
	stop := stopArg
				min: (self highBitOfBytes: magnitude).
	start > stop
		ifTrue: [^ false].
	firstByteIx := start - 1 // 8 + 1.
	lastByteIx := stop - 1 // 8 + 1.
	rightShift := (start - 1 \\ 8).
	leftShift := 7 - (stop - 1 \\ 8).
	firstByteIx = lastByteIx
		ifTrue: [| digit mask | 
			mask := (255 << rightShift) bitAnd: (255 >> leftShift).
			digit := self digitOfBytes: magnitude at: firstByteIx.
			^ (digit bitAnd: mask)
				~= 0].
	((self digitOfBytes: magnitude at: firstByteIx)
			>> rightShift)
			~= 0
		ifTrue: [^ true].
	firstByteIx + 1
		to: lastByteIx - 1
		do: [:ix | (self digitOfBytes: magnitude at: ix)
					~= 0
				ifTrue: [^ true]].
	(((self digitOfBytes: magnitude at: lastByteIx)
			<< leftShift)
			bitAnd: 255)
			~= 0
		ifTrue: [^ true].
	^ false