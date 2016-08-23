primitive support
internalPrimitiveResponse
	"Called under the assumption that primFunctionPtr has been preloaded"
	| delta nArgs |
	<inline: true>
	DoBalanceChecks ifTrue:["check stack balance"
		nArgs := argumentCount.
		delta := stackPointer - activeContext.
	].
	successFlag := true.
	self dispatchFunctionPointer: primitiveFunctionPointer.
	DoBalanceChecks ifTrue:[
		(self balancedStack: delta afterPrimitive: primitiveIndex withArgs: nArgs) 
			ifFalse:[self printUnbalancedStack: primitiveIndex].
	].
	"If we are profiling, take accurate primitive measures"
	nextProfileTick > 0 ifTrue:[
		self ioHighResClock >= nextProfileTick ifTrue:[
			"Take a profiler sample. Note that we sample the primitive method
			here because we don't want to attribute a failed primitive improperly."
			successFlag
				ifTrue: ["process the interrupt now"
						profileMethod := newMethod.
						self checkForInterrupts]
				ifFalse: ["process the interrupt in primtive failure code"
						profileMethod := nilObj.
						interruptCheckCounter := 0].
		].
	].
	primitiveIndex := 0. "clear out primIndex so VM knows we're no longer in primitive"
	^ successFlag
