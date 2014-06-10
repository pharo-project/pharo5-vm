system control primitives
primitiveMakeEphemeron
	"Turn the receiver into an ephemeron.
	 TEMPORARY. For testing ephemeron handling in the VM only.
	 Ephemerons should be instantiated from a suitable class."
	<export: true>
	<option: #SpurObjectMemory>
	((objectMemory isNonImmediate: self stackTop)
	 and: [objectMemory isFixedSizePointerFormat: (objectMemory formatOf: self stackTop)]) ifFalse:
		[^self primitiveFailFor: (argumentCount = 0
									ifTrue: [PrimErrBadReceiver]
									ifFalse: [PrimErrBadArgument])].
	objectMemory
		setFormatOf: self stackTop
		to: objectMemory ephemeronFormat.
	self pop: argumentCount