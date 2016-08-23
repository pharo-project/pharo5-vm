become implementation
followSpecialObjectsOop
	(self isForwarded: specialObjectsOop) ifTrue:
		[specialObjectsOop := self followForwarded: specialObjectsOop].
	self followForwardedObjectFields: specialObjectsOop toDepth: 0.