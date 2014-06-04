type inference
returnTypeForSend: aTSendNode
	"Answer the return type for a send.  Absent sends default to #sqInt."
	| sel |
	^(self anyMethodNamed: (sel := aTSendNode selector))
		ifNil: [kernelReturnTypes
				at: sel
				ifAbsent:
					[^sel
						caseOf: {
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