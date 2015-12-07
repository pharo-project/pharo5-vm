full transfer run-time support
callFullTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the full call immediately preceding callSiteReturnAddress will jump to."
	^self sixtyFourBitLiteralBefore: callSiteReturnAddress - 2