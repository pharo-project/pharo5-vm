inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the long constant loaded by a MoveCwR or PushCw before the given address"
	self flag: #bogus. "The caller ought to know what it is patching, and this should be split into separate methods with stricter checking. rmacnak 12/13/2015"
	
	"Cmp/MoveCwR
	 pc-8	lui rx, uper
	 pc-4	ori rx, rx, lower"
	(self opcodeAtAddress: followingAddress - 4) = ORI ifTrue:
		[^self literalAtAddress: followingAddress - 4 put: literal].

	"PushCw
	 pc-16	lui at, upper
	 pc-12	ori at, at, lower
	 pc-8	addiu sp, sp, -4
	 pc-4	sw at, 0(sp)"
	((self opcodeAtAddress: followingAddress - 4) = SW and:
		[(self opcodeAtAddress: followingAddress - 8) = ADDIU]) ifTrue:
			[^self literalAtAddress: followingAddress - 12 put: literal].
	
	self unreachable.
	^0