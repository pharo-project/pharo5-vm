I/O primitives
primitiveMousePoint

	| relPt |
	self pop: 1.
	displayForm == nil
		ifTrue: [self push: (self makePointwithxValue: 99 yValue: 66)]
		ifFalse: [relPt := Sensor cursorPoint - self displayLocation.
				self push: (self makePointwithxValue: relPt x yValue: relPt y)]