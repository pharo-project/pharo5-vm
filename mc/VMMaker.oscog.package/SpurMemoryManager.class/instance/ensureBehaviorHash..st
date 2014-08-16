class table
ensureBehaviorHash: aBehavior
	| newHash err |
	<inline: true>
	self assert: (coInterpreter addressCouldBeClassObj: aBehavior).
	(newHash := self rawHashBitsOf: aBehavior) = 0 ifTrue:
		[(err := self enterIntoClassTable: aBehavior) ~= 0 ifTrue:
			[^err negated].
		 newHash := self rawHashBitsOf: aBehavior.
		 self assert: (self classAtIndex: newHash) = aBehavior].
	^newHash