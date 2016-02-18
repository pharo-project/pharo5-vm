class table
ensureBehaviorHash: aBehavior
	| hash err |
	<inline: true>
	self assert: (coInterpreter addressCouldBeClassObj: aBehavior).
	^(hash := self rawHashBitsOf: aBehavior) ~= 0
		ifTrue:
			[hash]
		ifFalse:
			[(coInterpreter objCouldBeClassObj: aBehavior)
				ifFalse: [PrimErrBadReceiver negated]
				ifTrue:
					[(err := self enterIntoClassTable: aBehavior) ~= 0
						ifTrue: [err negated]
						ifFalse: [self rawHashBitsOf: aBehavior]]]