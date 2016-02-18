type inference
returnTypeForSend: sendNode in: aTMethod
	"Answer the return type for a send.  Absent sends default to #sqInt.
	 The bitwise operators answer unsigned versions of their argument types, at least in gcc
	 although this author can't find that in the C99 spec.  If you can find this, please let me know."
	| sel methodOrNil |
	methodOrNil := self anyMethodNamed: (sel := sendNode selector).
	(methodOrNil notNil and: [methodOrNil returnType notNil]) ifTrue:
		[^self baseTypeForType: methodOrNil returnType].
	^kernelReturnTypes
		at: sel
		ifAbsent:
			[sel
				caseOf: {
				[#+]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#-]						->	[self typeForArithmetic: sendNode in: aTMethod].
				[#*]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#/]						->	[self typeForArithmetic: sendNode in: aTMethod].
				[#addressOf:]			->	[(self typeFor: sendNode receiver in: aTMethod)
												ifNil: [#sqInt]
												ifNotNil: [:type| type, (type last isLetter ifTrue: [' *'] ifFalse: ['*'])]].
				[#at:]					->	[self typeForDereference: sendNode in: aTMethod].
				[#bitAnd:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitOr:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitXor:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#asFloat]				->	[#double].
				[#atan]					->	[#double].
				[#exp]					->	[#double].
				[#log]					->	[#double].
				[#sin]					->	[#double].
				[#sqrt]					->	[#double].
				[#asLong]				->	[#long].
				[#asUnsignedInteger]	->	[#usqInt].
				[#asUnsignedLong]		->	[#'unsigned long'].
				[#asVoidPointer]		->	[#'void *'].
				[#signedIntToLong]		->	[#usqInt]. "c.f. generateSignedIntToLong:on:indent:"
				[#signedIntToShort]	->	[#usqInt]. "c.f. generateSignedIntToShort:on:indent:"
				[#cCoerce:to:]			->	[sendNode args last value].
				[#cCoerceSimple:to:]	->	[sendNode args last value].
				[#ifTrue:ifFalse:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:ifTrue:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifTrue:]				->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:]				->	[self typeForConditional: sendNode in: aTMethod] }
				otherwise: "If there /is/ a method for sel but its retrn type is as yet unknown we /mustn't/ default it.
							We can only default unbound selectors."
					[methodOrNil ifNotNil: [nil] ifNil: [#sqInt]]]