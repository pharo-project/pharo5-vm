inline cacheing
callFullTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the call immediately preceeding callSiteReturnAddress will jump to."
	^self callTargetFromReturnAddress: callSiteReturnAddress