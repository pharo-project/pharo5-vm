header access
hashBitsOf: objOop
	| hash |
	hash := self rawHashBitsOf: objOop.
	hash = 0 ifTrue:
		["would like to assert
			self assert: (coInterpreter addressCouldBeClassObj: objOop) not
		  but instance-specific behaviors that are instances of themselves may
		  fail this test."
		 hash := self newObjectHash bitAnd: self identityHashHalfWordMask.
		 self setHashBitsOf: objOop to: hash].
	^hash