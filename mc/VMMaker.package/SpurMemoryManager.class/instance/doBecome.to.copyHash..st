become implementation
doBecome: obj1 to: obj2 copyHash: copyHashFlag
	| hashBits |
	self forward: obj1 to: obj2.
	copyHashFlag ifTrue:
		[hashBits := self rawHashBitsOf: obj2.
		 "silently refuse to change the hash of classes; this shouldn't happen anyway."
		 (self classAtIndex: hashBits) ~= obj2 ifTrue:
			[hashBits := self rawHashBitsOf: obj1.
			 self setHashBitsOf: obj2 to: hashBits]]