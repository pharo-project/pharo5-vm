oop functions
digitMontgomery: firstLarge times: secondLarge modulo: thirdLarge mInvModB: mInv
	<var: #mInv type: #'unsigned int'>
	| firstLen secondLen thirdLen prod |
	firstLen := self digitSizeOfLargeInt: firstLarge.
	secondLen := self digitSizeOfLargeInt: secondLarge.
	thirdLen := self digitSizeOfLargeInt: thirdLarge.

	firstLen <= thirdLen ifFalse: [^interpreterProxy primitiveFail].
	secondLen <= thirdLen ifFalse: [^interpreterProxy primitiveFail].
	self remapOop: #(firstLarge secondLarge thirdLarge) in: [prod := interpreterProxy instantiateClass: interpreterProxy classLargePositiveInteger indexableSize: thirdLen * 4].
	self
				cDigitMontgomery: (interpreterProxy firstIndexableField: firstLarge)
				len: firstLen
				times: (interpreterProxy firstIndexableField: secondLarge)
				len: secondLen
				modulo: (interpreterProxy firstIndexableField: thirdLarge)
				len: thirdLen
				mInvModB: mInv
				into: (interpreterProxy firstIndexableField: prod).
	^self normalizePositive: prod