object access primitives
primitiveClone
	"Return a shallow copy of the receiver.
	 Special-case non-single contexts (because of context-to-stack mapping).
	 Can't fail for contexts cuz of image context instantiation code (sigh).
	 Special case CompiledMerhods since the copy mustn't refer to CogMethod
	 if receiver has been cogged."

	| rcvr newCopy objHeader |
	rcvr := self stackTop.
	(objectMemory isImmediate: rcvr)
		ifTrue: [newCopy := rcvr]
		ifFalse:
			[objHeader := objectMemory baseHeader: rcvr.
			(objectMemory isContextHeader: objHeader)
				ifTrue: [newCopy := self cloneContext: rcvr]
				ifFalse: [newCopy := objectMemory clone: rcvr].
			newCopy = 0 ifTrue:
				[^self primitiveFailFor: PrimErrNoMemory].
			(objectMemory isCompiledMethodHeader: objHeader) ifTrue:
				["use stackTop since GC may have moved rcvr"
				 self rawHeaderOf: newCopy put: (self headerOf: self stackTop)]].
	self pop: argumentCount + 1 thenPush: newCopy