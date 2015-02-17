type inference
returnTypeForSend: sendNode in: aTMethod
	"Answer the return type for a send.  Absent sends default to #sqInt.
	 The bitwise operators answer unsigned versions of their argument types, at least in gcc
	 although this author can't find that in the C99 spec.  If you can find this, please let me know."
	| sel |
	^(self anyMethodNamed: (sel := sendNode selector))
		ifNil: [kernelReturnTypes
				at: sel
				ifAbsent:
					[^sel
						caseOf: {
						[#+]					->	[self typeForArithmetic: sendNode in: aTMethod].
						[#-]						->	[self typeForArithmetic: sendNode in: aTMethod].
						[#*]					->	[self typeForArithmetic: sendNode in: aTMethod].
						[#/]						->	[self typeForArithmetic: sendNode in: aTMethod].
						[#at:]					->	[self typeForDereference: sendNode in: aTMethod].
						[#bitAnd:]				->	[self unsignedTypeForBitwiseSend: sendNode in: aTMethod].
						[#bitOr:]				->	[self unsignedTypeForBitwiseSend: sendNode in: aTMethod].
						[#bitXor:]				->	[self unsignedTypeForBitwiseSend: sendNode in: aTMethod].
						[#asVoidPointer]		->	[#'void *'].
						[#asVoidPointer]		->	[#'void *'].
						[#asUnsignedInteger]	->	[#usqInt].
						[#asLong]				->	[#long].
						[#asUnsignedLong]		->	[#'unsigned long'].
						[#signedIntToLong]		->	[#usqInt]. "c.f. generateSignedIntToLong:on:indent:"
						[#signedIntToShort]	->	[#usqInt]. "c.f. generateSignedIntToShort:on:indent:"
						[#cCoerce:to:]			->	[sendNode args last value].
						[#cCoerceSimple:to:]	->	[sendNode args last value] }
						otherwise: [#sqInt]]]
		ifNotNil:
			[:m|
			m returnType ifNotNil:
				[:type| "map fields to #usqInt"
				((type beginsWith: 'unsigned')
				 and: [(type includes: $:)
				 and: [type last isDigit]])
					ifTrue: [#usqInt]
					ifFalse: [type]]]