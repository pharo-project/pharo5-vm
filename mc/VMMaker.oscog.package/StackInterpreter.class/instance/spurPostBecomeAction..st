object memory support
spurPostBecomeAction: theBecomeEffectsFlags
	"Insulate the stack zone from the effects of a become.
	 All receivers must be unfollowed for two reasons:
		1. inst var access is direct with no read barrier
		2. super sends (always to the receiver) have no class check and so don't trap
		   for forwarded receivers.  This is an issue for primitives that assume their receiver
		   is valid and don't validate.
	 Super sends require an explicit check to ensure receivers in super sends are unforwarded.
	 e.g. super doSomethingWith: (self become: other) forwards the receiver self pushed on the
	 stack.  So we could avoid following non-pointer receivers.  But this is too tricky,  Instead, we
	 always follow receivers.
	 Methods must be unfollowed since bytecode access is direct with no read barrier.
	 But this only needs to be done if the becomeEffectsFlags indicate that a
	 CompiledMethod was becommed.
	 The scheduler state must be followed, but only if the becomeEffectsFlags indicate
	 that a pointer object was becommed."
	<option: #SpurObjectMemory>
	<inline: false> "For VM profiling"
	self flushAtCache.
	theBecomeEffectsFlags ~= 0 ifTrue:
		[(theBecomeEffectsFlags anyMask: BecameCompiledMethodFlag) ifTrue:
			[self followForwardedMethodsInMethodCache.
			 self followForwardedMethodsInMethodZone]. "for CoInterpreter; must precede followForwardingPointersInStackZone:"
		 (theBecomeEffectsFlags anyMask: BecameActiveClassFlag) ifTrue:
			[self flushBecommedClassesInMethodCache.
			 self flushBecommedClassesInMethodZone]. "for CoInterpreter"
		 (theBecomeEffectsFlags anyMask: BecamePointerObjectFlag) ifTrue:
			[self followForwardingPointersInScheduler.
			 self followForwardingPointersInSpecialObjectsArray].
		 (theBecomeEffectsFlags anyMask: BecamePointerObjectFlag + BecameCompiledMethodFlag) ifTrue:
			[self followForwardingPointersInProfileState]].
	self followForwardingPointersInStackZone: theBecomeEffectsFlags