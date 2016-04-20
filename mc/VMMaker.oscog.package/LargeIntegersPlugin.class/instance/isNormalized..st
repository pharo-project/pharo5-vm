oop functions
isNormalized: aLargeInteger 
	| len |
	"Check for leading zero of LargeInteger"
	len := self byteSizeOfLargeInt: aLargeInteger.
	len = 0 ifTrue:
		[^ false].
	(self unsafeByteOfLargeInt: aLargeInteger at: len) = 0 ifTrue:
		[^ false].
	^true