primitive support
checkForAndFollowForwardedPrimitiveState
	"In Spur a primitive may fail due to encountering a forwarder.
	 On failure check the accessorDepth for the primitive and
	 if non-negative scan the args to the depth, following any
	 forwarders.  Answer if any are found so the prim can be retried."
	<option: #SpurObjectMemory>
	^self checkForAndFollowForwardedPrimitiveStateFor: (self primitiveIndexOf: newMethod)