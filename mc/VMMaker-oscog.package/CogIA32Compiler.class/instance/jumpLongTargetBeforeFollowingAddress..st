inline cacheing
jumpLongTargetBeforeFollowingAddress: mcpc 
	"Answer the target address for the long jump immediately preceeding mcpc"
	^self callTargetFromReturnAddress: mcpc