type inference
returnTypeForSend: aTSendNode in: aTMethod
	"Answer the return type for a send.  Absent sends default to #sqInt.
	 The bitwise operators answer unsigned versions of their argument types, at least in gcc
	 although this author can't find that in the C99 spec.  If you can find this, please let me know."
	| sel |
	^(self anyMethodNamed: (sel := aTSendNode selector))
		ifNil: [kernelReturnTypes
				at: sel
				ifAbsent:
					[^sel
						caseOf: {
						[#bitAnd:]				->	[self unsignedTypeForBitwiseSend: aTSendNode in: aTMethod].
						[#bitOr:]				->	[self unsignedTypeForBitwiseSend: aTSendNode in: aTMethod].
						[#bitXor:]				->	[self unsignedTypeForBitwiseSend: aTSendNode in: aTMethod].
						[#asVoidPointer]		->	[#'void *'].
						[#asVoidPointer]		->	[#'void *'].
						[#asUnsignedInteger]	->	[#usqInt].
						[#asLong]				->	[#long].
						[#asUnsignedLong]		->	[#'unsigned long'].
						[#signedIntToLong]		->	[#usqInt]. "c.f. generateSignedIntToLong:on:indent:"
						[#signedIntToShort]	->	[#usqInt]. "c.f. generateSignedIntToShort:on:indent:"
						[#cCoerce:to:]			->	[aTSendNode args last value].
						[#cCoerceSimple:to:]	->	[aTSendNode args last value] }
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