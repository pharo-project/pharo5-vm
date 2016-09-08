inline cacheing
literal32BeforeFollowingAddress: followingAddress
	"Answer the 32-bit literal embedded in the instruction immediately preceding followingAddress."
	^cogit
		cCoerceSimple: (self unalignedLong32At: followingAddress - 4)
		to: #'unsigned int'