type inference
returnTypeForSend: sendNode in: aTMethod
	"Answer the return type for a send.  Absent sends default to #sqInt.
	 The inferred type should match as closely as possible the C type of
	 generated expessions so that inlining would not change the expression."
	| sel methodOrNil |
	methodOrNil := self anyMethodNamed: (sel := sendNode selector).
	(methodOrNil notNil and: [methodOrNil returnType notNil]) ifTrue:
		[^self baseTypeForType: methodOrNil returnType].
	^kernelReturnTypes
		at: sel
		ifAbsent:
			[sel
				caseOf: {
				[#negated]				->	[self promoteArithmeticTypes: (self typeFor: sendNode receiver in: aTMethod) and: #int].
				[#+]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#-]						->	[self typeForArithmetic: sendNode in: aTMethod].
				[#*]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#/]						->	[self typeForArithmetic: sendNode in: aTMethod].
				[#//]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#\\]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#>>]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#<<]					->	[self
												promoteArithmeticTypes: (self unsignedTypeForIntegralType: (self typeFor: sendNode receiver in: aTMethod))
												and: (self typeFor: sendNode args first in: aTMethod)].
				[#rem:]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#quo:]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#addressOf:]			->	[(self typeFor: sendNode receiver in: aTMethod)
												ifNil: [#sqInt]
												ifNotNil: [:type| type, (type last isLetter ifTrue: [' *'] ifFalse: ['*'])]].
				[#at:]					->	[self typeForDereference: sendNode in: aTMethod].
				[#bitAnd:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitOr:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitXor:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitClear:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitInvert32]			->	[#'unsigned int'].
				[#bitInvert64]			->	[self promoteArithmeticTypes: (self typeFor: sendNode receiver in: aTMethod) and: #int].
				[#byteSwap32]			->	[#'unsigned int'].
				[#byteSwap64]			->	[#'unsigned long long'].
				[#byteSwapped32IfBigEndian:]	->	[#'unsigned int'].
				[#byteSwapped64IfBigEndian:]	->	[#'unsigned long long'].
				[#=]					->	[#int].
				[#~=]					->	[#int].
				[#==]					->	[#int].
				[#~~]					->	[#int].
				[#<]					->	[#int].
				[#<=]					->	[#int].
				[#>]					->	[#int].
				[#>=]					->	[#int].
				[#between:and:]		->	[#int].
				[#anyMask:]				->	[#int].
				[#allMask:]				->	[#int].
				[#noMask:]				->	[#int].
				[#isNil]					->	[#int].
				[#notNil]				->	[#int].
				[#&]					->	[#int].
				[#|]						->	[#int].
				[#not]					->	[#int].
				[#asFloat]				->	[#double].
				[#atan]					->	[#double].
				[#exp]					->	[#double].
				[#log]					->	[#double].
				[#sin]					->	[#double].
				[#sqrt]					->	[#double].
				[#asLong]				->	[#long].
				[#asInteger]			->	[#sqInt].
				[#asUnsignedInteger]	->	[#usqInt].
				[#asUnsignedLong]		->	[#'unsigned long'].
				[#asVoidPointer]		->	[#'void *'].
				[#signedIntToLong]		->	[#usqInt]. "c.f. generateSignedIntToLong:on:indent:"
				[#signedIntToShort]	->	[#usqInt]. "c.f. generateSignedIntToShort:on:indent:"
				[#cCoerce:to:]			->	[sendNode args last value].
				[#cCoerceSimple:to:]	->	[sendNode args last value].
				[#sizeof:]				->	[#'unsigned long']. "Technically it's a size_t but it matches unsigned long on target architectures so far..."
				[#ifTrue:ifFalse:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:ifTrue:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifTrue:]				->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:]				->	[self typeForConditional: sendNode in: aTMethod] }
				otherwise: "If there /is/ a method for sel but its retrn type is as yet unknown we /mustn't/ default it.
							We can only default unbound selectors."
					[methodOrNil ifNotNil: [nil] ifNil: [#sqInt]]]