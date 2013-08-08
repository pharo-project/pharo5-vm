accessing
dispose

	(0 = (self at: 2)) ifTrue:
		[self error: 'cannot dispose of unallocated space'].
	self primAEDisposeDesc isZero ifFalse: 
		[self error: 'dispose operation failed'].
	self at: 1 put: 0.
	self at: 2 put: 0.
	^nil