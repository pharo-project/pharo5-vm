object memory support
postBecomeAction: becomeEffectsFlags
	becomeEffectsFlags ~= 0 ifTrue:
		[self followForwardingPointersInStackZone: becomeEffectsFlags]