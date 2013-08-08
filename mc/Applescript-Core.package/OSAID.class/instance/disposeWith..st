creation/release
disposeWith: aComponent

	| result |
	(0 = (self at: 1)) ifTrue:
		[self error: 'cannot dispose unallocated OSAID'].
	result := aComponent primOSADispose: self.
	result isZero ifFalse: 
		[self error: 'dispose operation failed'].
	self at: 1 put: 0.
	^nil