*MethodMassage-disassembly
literalIndexOfBytecodeAt: pc in: aCompiledMethod
	"32-63 		001iiiii 						Push Literal Constant #iiiii
	 64-95 		010iiiii 						Push Literal Variable #iiiii
	 128 		10000000 jjkkkkkk 		Push (Receiver Variable, Temporary Location, Literal Constant, Literal Variable) [jj] #kkkkkk
	129 		10000001 jjkkkkkk 		Store (Receiver Variable, Temporary Location, Illegal, Literal Variable) [jj] #kkkkkk
	130 		10000010 jjkkkkkk 		Pop and Store (Receiver Variable, Temporary Location, Illegal, Literal Variable) [jj] #kkkkkk
	132 		10000100 iiijjjjj kkkkkkkk 	(Send, Send Super, Push Receiver Variable, Push Literal Constant, Push Literal Variable, Store Receiver Variable, Store-Pop Receiver Variable, Store Literal Variable)[iii] #kkkkkkkk jjjjj (for sends jjjjj = numArgs)"
	| byte type |
	byte := aCompiledMethod at: pc.
	byte <= 95 ifTrue:
		[^byte >= 32 ifTrue:
			[byte bitAnd: 16r1F]].
	(byte between: 128 and: 130) ifTrue:
		[^(aCompiledMethod at: pc + 1) bitAnd: 16r3F].
	byte = 132 ifTrue:
	[type := (aCompiledMethod at: pc + 1) bitShift: -5.
	 (type = 3 or: [type = 4 or: [type = 7]]) ifTrue:
		[^aCompiledMethod at: pc + 2]].
	^nil