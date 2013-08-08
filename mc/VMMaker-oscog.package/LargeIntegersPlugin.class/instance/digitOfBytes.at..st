util
digitOfBytes: aBytesOop at: ix 
	"Argument has to be aLargeInteger!"
	ix > (self byteSizeOfBytes: aBytesOop)
		ifTrue: [^ 0]
		ifFalse: [^ self unsafeByteOf: aBytesOop at: ix]