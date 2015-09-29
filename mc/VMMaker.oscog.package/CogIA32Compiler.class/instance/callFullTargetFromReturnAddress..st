inline cacheing
callFullTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the call immediately preceding callSiteReturnAddress will jump to."
	^self callTargetFromReturnAddress: callSiteReturnAddress