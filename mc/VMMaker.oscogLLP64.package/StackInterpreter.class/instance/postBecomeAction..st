object memory support
postBecomeAction: theBecomeEffectsFlags
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[self spurPostBecomeAction: theBecomeEffectsFlags]