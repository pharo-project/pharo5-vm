primitive support
slowPrimitiveResponse
	"Invoke a normal (non-quick) primitive.
	 Called under the assumption that primFunctionPointer has been preloaded."
	| nArgs savedFramePointer savedStackPointer |
	<inline: true>
	<var: #savedFramePointer type: #'char *'>
	<var: #savedStackPointer type: #'char *'>
	self assert: (objectMemory isOopForwarded: (self stackValue: argumentCount)) not.
	self assert: objectMemory remapBufferCount = 0.
	FailImbalancedPrimitives ifTrue:
		[nArgs := argumentCount.
		 savedStackPointer := stackPointer.
		 savedFramePointer := framePointer].
	self initPrimCall.
	self dispatchFunctionPointer: primitiveFunctionPointer.
	self assert: (self maybeLeakCheckExternalPrimCall: newMethod).
	self maybeRetryPrimitiveOnFailure.
	self maybeFailForLastObjectOverwrite.
	(FailImbalancedPrimitives
	and: [self successful
	and: [framePointer = savedFramePointer
	and: [(self isMachineCodeFrame: framePointer) not]]]) ifTrue:"Don't fail if primitive has done something radical, e.g. perform:"
		[stackPointer ~= (savedStackPointer + (nArgs * objectMemory wordSize)) ifTrue:
			[self flag: 'Would be nice to make this a message send of e.g. unbalancedPrimitive to the current process or context'.
			 "This is necessary but insufficient; the result may still have been written to the stack.
			   At least we'll know something is wrong."
			 stackPointer := savedStackPointer.
			 self failUnbalancedPrimitive]].
	"If we are profiling, take accurate primitive measures"
	nextProfileTick > 0 ifTrue:
		[self checkProfileTick: newMethod].
	^self successful