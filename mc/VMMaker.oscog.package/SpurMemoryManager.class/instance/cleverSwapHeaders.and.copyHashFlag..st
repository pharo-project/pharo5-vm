become implementation
cleverSwapHeaders: obj1 and: obj2 copyHashFlag: copyHashFlag
	"swap headers, but swapping headers swaps remembered bits and hashes;
	 remembered bits must be unswapped and hashes may be unswapped if
	 copyHash is false."
	"This variant doesn't tickle a compiler bug in gcc and clang.  See naiveSwapHeaders:and:copyHashFlag:"
	<inline: true>
	| header1 header2 remembered1 remembered2 |
	header1 := self long64At: obj1.
	header2 := self long64At: obj2.
	remembered1 := header1 bitAnd: 1 << self rememberedBitShift.
	remembered2 := header2 bitAnd: 1 << self rememberedBitShift.
	remembered1 ~= remembered2 ifTrue:
		[header1 := header1 - remembered1 + remembered2.
		 header2 := header2 - remembered2 + remembered1].
	"swapping headers swaps hash; if not copyHashFlag then unswap hash"
	copyHashFlag ifFalse:
		[| hash1 hash2 |
		 hash1 := header1 bitAnd: self identityHashFullWordMask.
		 hash2 := header2 bitAnd: self identityHashFullWordMask.
		 hash1 ~= hash2 ifTrue:
			[header1 := header1 - hash1 + hash2.
			 header2 := header2 - hash2 + hash1]].
	self long64At: obj1 put: header2.
	self long64At: obj2 put: header1