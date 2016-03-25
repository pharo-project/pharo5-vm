util
digitOfLargeInt: aBytesOop at: ix 
	"Argument has to be aLargeInteger!"
	ix > (self digitSizeOfLargeInt: aBytesOop)
		ifTrue: [^ 0]
		ifFalse: [^ self unsafeDigitOf: aBytesOop at: ix]