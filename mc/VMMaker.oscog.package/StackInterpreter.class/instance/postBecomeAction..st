object memory support
postBecomeAction: theBecomeEffectsFlags
	"Insulate the stack zone from the effects of a become.
	 All receivers must be unfollowed for two reasons:
		1. inst var access is direct with no read barrier
		2. super sends (always to the receiver) have no class check and so don't trap
		   for forwarded receivers.
	 Methods must be unfollowed since bytecode access is direct with no read barrier.
	 But this only needs to be done if the becomeEffectsFlags indicate that a
	 CompiledMethod was becommed.
	 The sceduler state must be followed, but only if the becomeEffectsFlags indicate
	 that a pointer object was becommed."
	self followForwardingPointersInStackZone: theBecomeEffectsFlags.
	theBecomeEffectsFlags ~= 0 ifTrue:
		[(theBecomeEffectsFlags anyMask: BecameCompiledMethodFlag) ifTrue:
			[self followForwardedMethodsInMethodCache.
			 self followForwardedMethodsInMethodZone]. "for CoInterpreter"
		 self followForwardingPointersInScheduler]