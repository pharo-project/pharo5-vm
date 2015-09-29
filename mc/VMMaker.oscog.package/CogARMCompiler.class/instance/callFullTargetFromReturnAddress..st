inline cacheing
callFullTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address that the call immediately preceding callSiteReturnAddress will jump to."
	"this is also used by #jumpLongTargetBeforeFollowingAddress: and so we check for both call and jump related instructions; later on we can use simpler tests once it feels safe to assume we get here always with a call/jump in the proper place"
	^self subclassResponsibility