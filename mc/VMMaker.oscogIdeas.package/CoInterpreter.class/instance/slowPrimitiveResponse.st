primitive support
slowPrimitiveResponse
	"Invoke a normal (non-quick) primitive.
	 Called under the assumption that primFunctionPointer has been preloaded.
	 Override to log primitive."
	cogit recordPrimTrace ifTrue:
		[self fastLogPrim: messageSelector].
	^super slowPrimitiveResponse