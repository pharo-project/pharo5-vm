util
anyBitOfLargeInt: anOop from: start to: stopArg 
	"Argument has to be a Large Integer!"
	"Tests for any magnitude bits in the interval from start to stopArg."
	| magnitude stop firstDigitIx lastDigitIx firstMask lastMask |
	<var: #digit type: #'unsigned int'>
	<var: #firstMask type: #'unsigned int'>
	<var: #lastMask type: #'unsigned int'>
	<var: #firstDigitIx type: #usqInt>
	<var: #lastDigitIx type: #usqInt>
	<var: #ix type: #usqInt>
	self
		debugCode: [self msg: 'anyBitOfLargeInt: anOop from: start to: stopArg'].
	start < 1 | (stopArg < 1)
		ifTrue: [^ interpreterProxy primitiveFail].
	magnitude := anOop.
	stop := stopArg min: (self highBitOfLargeInt: magnitude).
	start > stop
		ifTrue: [^ false].
	firstDigitIx := start - 1 // 32 + 1.
	lastDigitIx := stop - 1 // 32 + 1.
	firstMask := 16rFFFFFFFF << (start - 1 bitAnd: 31).
	lastMask := 16rFFFFFFFF >> (31 - (stop - 1 bitAnd: 31)).
	firstDigitIx = lastDigitIx
		ifTrue: [| digit | 
			digit := self unsafeDigitOfLargeInt: magnitude at: firstDigitIx.
			^ (digit bitAnd: (firstMask bitAnd: lastMask))
				~= 0].
	((self unsafeDigitOfLargeInt: magnitude at: firstDigitIx) bitAnd: firstMask)
			~= 0
		ifTrue: [^ true].
	firstDigitIx + 1
		to: lastDigitIx - 1
		do: [:ix | (self unsafeDigitOfLargeInt: magnitude at: ix)
					~= 0
				ifTrue: [^ true]].
	((self unsafeDigitOfLargeInt: magnitude at: lastDigitIx)  bitAnd: lastMask)
			~= 0
		ifTrue: [^ true].
	^ false