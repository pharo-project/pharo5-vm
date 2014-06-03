message sending
executeNewMethod
	"Execute newMethod - either primitiveIndex must be set directly
	 (i.e. from primitiveExecuteMethod et al), or it would have been
	 set probing the method cache (i.e. primitivePerform et al)."
	primitiveIndex > 0
		ifTrue: [self primitiveResponse.
			successFlag ifTrue: [^ nil]].
	"if not primitive, or primitive failed, activate the method"
	self activateNewMethod.
	"check for possible interrupts at each real send"
	self quickCheckForInterrupts