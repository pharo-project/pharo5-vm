oop functions
digitMontgomery: firstLarge times: secondLarge modulo: thirdLarge mInvModB: mInv
	<var: #mInv type: #'unsigned int'>
	| firstLen secondLen thirdLen prod |
	firstLen := self digitSizeOfLargeInt: firstLarge.
	secondLen := self digitSizeOfLargeInt: secondLarge.
	thirdLen := self digitSizeOfLargeInt: thirdLarge.
	(firstLen <= thirdLen and: [secondLen <= thirdLen]) ifFalse: [^interpreterProxy primitiveFail].

	self remapOop: #(firstLarge secondLarge thirdLarge)
		in: [prod := interpreterProxy instantiateClass: interpreterProxy classLargePositiveInteger indexableSize: thirdLen * 4].
	prod ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	self
		cDigitMontgomery: (self pointerToFirstDigitOfLargeInt: firstLarge)
		len: firstLen
		times: (self pointerToFirstDigitOfLargeInt: secondLarge)
		len: secondLen
		modulo: (self pointerToFirstDigitOfLargeInt: thirdLarge)
		len: thirdLen
		mInvModB: mInv
		into: (self pointerToFirstDigitOfLargeInt: prod).
	^self normalizePositive: prod