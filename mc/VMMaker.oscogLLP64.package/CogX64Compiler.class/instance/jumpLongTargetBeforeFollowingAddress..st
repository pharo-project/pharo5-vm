inline cacheing
jumpLongTargetBeforeFollowingAddress: mcpc 
	"Answer the target address for the long jump immediately preceding mcpc"
	^self callTargetFromReturnAddress: mcpc