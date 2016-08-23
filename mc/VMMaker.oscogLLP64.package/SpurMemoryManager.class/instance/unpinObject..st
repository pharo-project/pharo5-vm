primitive support
unpinObject: objOop
	self assert: (self isNonImmediate: objOop).
	self setIsPinnedOf: objOop to: false.
	^0