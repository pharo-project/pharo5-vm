message sending
executeNewMethod
	"Execute newMethod - either primitiveFunctionPointer must be set directly
	 (i.e. from primitiveExecuteMethod et al), or it would have been set probing
	 the method cache (i.e. primitivePerform et al)."
	primitiveFunctionPointer ~= 0 ifTrue:
		[self isPrimitiveFunctionPointerAnIndex ifTrue:
			[self externalQuickPrimitiveResponse.
			 ^nil].
		 self slowPrimitiveResponse.
		 self successful ifTrue: [^nil]].
	"if not primitive, or primitive failed, activate the method"
	self activateNewMethod