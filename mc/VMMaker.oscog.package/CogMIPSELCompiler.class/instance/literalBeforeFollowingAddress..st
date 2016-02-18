inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the literal embedded in the instruction immediately preceding followingAddress.
	 This is used in the MoveCwR, PushCw and CmpCwR cases."
	
	"Cmp/MoveCwR
	 pc-8	lui rx, uper
	 pc-4	ori rx, rx, lower"
	(self opcodeAtAddress: followingAddress - 4) = ORI ifTrue:
		[^self literalAtAddress: followingAddress - 4].
	
	"PushCw
	 pc-16	lui at, upper
	 pc-12	ori at, at, lower
	 pc-8	addiu sp, sp, -4
	 pc-4	sw at, 0(sp)"
	((self opcodeAtAddress: followingAddress - 4) = SW and:
		[(self opcodeAtAddress: followingAddress - 8) = ADDIU]) ifTrue:
			[^self literalAtAddress: followingAddress - 12].
	
	self unreachable.
	^0