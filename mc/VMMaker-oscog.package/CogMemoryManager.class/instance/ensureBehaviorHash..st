class table
ensureBehaviorHash: aBehavior
	| newHash err |
	self assert: (self isIntegerObject: aBehavior) not.
	(newHash := self hashBitsOf: aBehavior) = 0 ifTrue:
		[(err := self enterIntoClassTable: aBehavior) ~= 0 ifTrue:
			[^err negated].
		 newHash := self hashBitsOf: aBehavior].
	^newHash