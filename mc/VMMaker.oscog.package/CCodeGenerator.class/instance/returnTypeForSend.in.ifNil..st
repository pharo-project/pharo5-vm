type inference
returnTypeForSend: sendNode in: aTMethod ifNil: typeIfNil
	"Answer the return type for a send.  Unbound sends default to typeIfNil.
	 Methods with types as yet unknown have a type determined either by the
	 kernelReturnTypes or the table below, or, if they are in neither set, then nil.
	 The inferred type should match as closely as possible the C type of
	 generated expessions so that inlining would not change the expression.
	 If there is a method for sel but its return type is as yet unknown it mustn't
	 be defaulted, since on a subsequent pass its type may be computable."
	| sel methodOrNil |
	methodOrNil := self anyMethodNamed: (sel := sendNode selector).
	(methodOrNil notNil and: [methodOrNil returnType notNil]) ifTrue:
		[^self baseTypeForType: methodOrNil returnType].
	^kernelReturnTypes
		at: sel
		ifAbsent:
			[sel
				caseOf: {
				[#integerValueOf:]		->	[#sqInt].
				[#isIntegerObject:]		->	[#int].
				[#negated]				->	[self promoteArithmeticTypes: (self typeFor: sendNode receiver in: aTMethod) and: #int].
				[#+]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#-]						->	[self typeForArithmetic: sendNode in: aTMethod].
				[#*]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#/]						->	[self typeForArithmetic: sendNode in: aTMethod].
				[#//]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#\\]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#rem:]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#quo:]					->	[self typeForArithmetic: sendNode in: aTMethod].
				"C99 Sec Bitwise shift operators ... 3 Sematics ...
				 The integer promotions are performed on each of the operands. The type of the result is that of the promoted left operand..."
				[#>>]					->	[self typeFor: sendNode receiver in: aTMethod].
				[#<<]					->	[self typeFor: sendNode receiver in: aTMethod].
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
				[#asIntegerPtr]			->	[#'sqIntptr_t'].
				[#asUnsignedInteger]	->	[#usqInt].
				[#asUnsignedIntegerPtr]->	[#'usqIntptr_t'].
				[#asUnsignedLong]		->	[#'unsigned long'].
				[#asUnsignedLongLong]		->	[#'unsigned long long'].
				[#asVoidPointer]		->	[#'void *'].
				[#signedIntToLong]		->	[#usqInt]. "c.f. generateSignedIntToLong:on:indent:"
				[#signedIntToShort]	->	[#usqInt]. "c.f. generateSignedIntToShort:on:indent:"
				[#cCoerce:to:]			->	[sendNode args last value].
				[#cCoerceSimple:to:]	->	[sendNode args last value].
				[#sizeof:]				->	[#'usqIntptr_t']. "Technically it's a size_t but it matches on target architectures so far..."
				[#ifTrue:ifFalse:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:ifTrue:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifTrue:]				->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:]				->	[self typeForConditional: sendNode in: aTMethod].
				[#and:]					->	[#sqInt].
				[#or:]					->	[#sqInt] }
				otherwise: "If there /is/ a method for sel but its return type is as yet unknown it /mustn't/ be defaulted,
							since on a subsequent pass its type may be computable.  Only default unbound selectors."
					[methodOrNil ifNotNil: [nil] ifNil: [typeIfNil]]]