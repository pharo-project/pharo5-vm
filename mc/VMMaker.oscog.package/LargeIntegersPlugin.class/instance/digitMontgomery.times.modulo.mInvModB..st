oop functions
digitMontgomery: firstLarge times: secondLarge modulo: thirdLarge mInvModB: mInv

	| firstLen secondLen thirdLen prod |
	firstLen := self byteSizeOfBytes: firstLarge.
	secondLen := self byteSizeOfBytes: secondLarge.
	thirdLen := self byteSizeOfBytes: thirdLarge.

	firstLen <= thirdLen ifFalse: [^interpreterProxy primitiveFail].
	secondLen <= thirdLen ifFalse: [^interpreterProxy primitiveFail].
	(mInv >= 0 and: [mInv <= 255]) ifFalse: [^interpreterProxy primitiveFail].
	self remapOop: #(firstLarge secondLarge thirdLarge) in: [prod := interpreterProxy instantiateClass: interpreterProxy classLargePositiveInteger indexableSize: thirdLen].
	self
				cdigitMontgomery: (interpreterProxy firstIndexableField: firstLarge)
				len: firstLen
				times: (interpreterProxy firstIndexableField: secondLarge)
				len: secondLen
				modulo: (interpreterProxy firstIndexableField: thirdLarge)
				len: thirdLen
				mInvModB: mInv
				into: (interpreterProxy firstIndexableField: prod).
	^self normalizePositive: prod