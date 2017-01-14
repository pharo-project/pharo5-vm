become implementation
naiveSwapHeaders: obj1 and: obj2 copyHashFlag: copyHashFlag
	"swap headers, but swapping headers swaps remembered bits and hashes;
	 remembered bits must be unswapped and hashes may be unswapped if
	 copyHash is false."
	"This variant tickles a compiler bug in gcc and clang. See cleverSwapHeaders:and:copyHashFlag:"
	<inline: true>
	| headerTemp remembered1 remembered2 hashTemp |
	remembered1 := self isRemembered: obj1.
	remembered2 := self isRemembered: obj2.
	headerTemp := self long64At: obj1.
	self long64At: obj1 put: (self long64At: obj2).
	self long64At: obj2 put: headerTemp.
	self setIsRememberedOf: obj1 to: remembered1.
	self setIsRememberedOf: obj2 to: remembered2.
	"swapping headers swaps hash; if !copyHashFlag undo hash copy"
	copyHashFlag ifFalse:
		[hashTemp := self rawHashBitsOf: obj1.
		 self setHashBitsOf: obj1 to: (self rawHashBitsOf: obj2).
		 self setHashBitsOf: obj2 to: hashTemp]