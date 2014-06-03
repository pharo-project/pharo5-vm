become implementation
followSpecialObjectsOop
	(self isForwarded: specialObjectsOop) ifTrue:
		[specialObjectsOop := self followForwarded: specialObjectsOop]