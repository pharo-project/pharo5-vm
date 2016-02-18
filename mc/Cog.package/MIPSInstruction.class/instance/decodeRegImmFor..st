as yet unclassified
decodeRegImmFor: visitor
	| fn |
	fn := self rt.
	fn = BLTZ ifTrue: [^visitor branchLessThanZero: self].
	fn = BGEZ ifTrue: [^visitor branchGreaterEqualZero: self].
	
	self error: 'Unknown instruction'.