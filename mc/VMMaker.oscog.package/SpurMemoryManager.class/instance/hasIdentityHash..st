header access
hasIdentityHash: objOop
	<inline: true>
	^self cCode: [self rawHashBitsOf: objOop]
		inSmalltalk: [(self rawHashBitsOf: objOop) ~= 0]