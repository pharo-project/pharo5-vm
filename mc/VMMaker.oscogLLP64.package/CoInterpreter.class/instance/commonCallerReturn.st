return bytecodes
commonCallerReturn
	"Return to the previous context/frame (sender for method activations, caller for block activations)."
	<sharedCodeNamed: 'commonCallerReturn' inCase: #returnTopFromBlock>
	| callersFPOrNull doWeHaveANativeFrame |
	<var: #callersFPOrNull type: #'char *'>

	"TODO: Store/restore the nativeSP more properly, when it exists"
	LowcodeVM ifTrue: [ 
		doWeHaveANativeFrame := self frameHasNativeFrame: localFP.
		doWeHaveANativeFrame ifTrue: [
			nativeStackPointer := (self nativePreviousStackPointerIn: localFP) - 1.
			nativeSP := 0.
			self setFrameHasNotNativeFrame: localFP.
		].
	].

	callersFPOrNull := self frameCallerFP: localFP.
	callersFPOrNull == 0 "baseFrame" ifTrue:
		[self assert: localFP = stackPage baseFP.
		 ^self baseFrameReturn].

	localIP := self frameCallerSavedIP: localFP.
	localSP := localFP + (self frameStackedReceiverOffset: localFP).
	localFP := callersFPOrNull.
	localIP asUnsignedInteger < objectMemory startOfMemory ifTrue:
		[localIP asUnsignedInteger ~= cogit ceReturnToInterpreterPC ifTrue:
			["localIP in the cog method zone indicates a return to machine code."
			 ^self returnToMachineCodeFrame].
		 localIP := self pointerForOop: (self iframeSavedIP: localFP)].
	self setMethod: (self iframeMethod: localFP).
	self fetchNextBytecode.
	self internalStackTopPut: localReturnValue