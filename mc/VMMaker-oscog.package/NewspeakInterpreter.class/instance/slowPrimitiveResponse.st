primitive support
slowPrimitiveResponse
	"NB: tpr removed the timer checks here and moved them to the primitiveExternalCall method.
	We make the possibly unwarranted assumption that numbered prims are quick and external prims are slow."

	| nArgs deltaIfSuccess savedContext |
	<inline: true>
	FailImbalancedPrimitives ifTrue:
		[savedContext := activeContext.
		 nArgs := argumentCount.
		 deltaIfSuccess := stackPointer - (argumentCount * BytesPerOop) - activeContext].
	self fastLogPrim: messageSelector.
	self initPrimCall.
	self dispatchFunctionPointer: primitiveFunctionPointer.
	(FailImbalancedPrimitives
	and: [self successful
	and: [savedContext = activeContext]]) ifTrue:"Don't fail if primitive has done something radical, e.g. perform:"
		[stackPointer - activeContext ~= deltaIfSuccess ifTrue:
			[self flag: 'Would be nice to make this a message send of e.g. unbalancedPrimitive to the current process or context'.
			 self warning: 'failing primitive due to unbalanced stack'.
			 "This is necessary but insufficient; the result may still have been written to the stack.
			   At least we'll know something is wrong."
			 stackPointer := activeContext + deltaIfSuccess + (nArgs * BytesPerOop).
			 self failUnbalancedPrimitive]].
	^ self successful