return bytecodes
commonCallerReturn
	"Return to the previous context/frame (sender for method activations, caller for block activations)."
	<sharedCodeNamed: 'commonCallerReturn' inCase: #returnTopFromBlock>
	| callersFPOrNull |
	<var: #callersFPOrNull type: #'char *'>

	callersFPOrNull := self frameCallerFP: localFP.
	callersFPOrNull == 0 "baseFrame" ifTrue:
		[self assert: localFP = stackPage baseFP.
		 ^self baseFrameReturn].

	localIP := self frameCallerSavedIP: localFP.
	localSP := localFP + (self frameStackedReceiverOffset: localFP).
	localFP := callersFPOrNull.
	self setMethod: (self frameMethod: localFP).
	self fetchNextBytecode.
	self internalStackTopPut: localReturnValue