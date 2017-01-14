stack depth
resetStackAfterBranchOrReturn
	pc <= joins size ifTrue:
		[(joins at: pc) ifNil:
			["We would like to raise an error here, but we can't because the bytecode
			  compiler doesn't remove dead code.  e.g. the following doesn't reach ^nil
			  but is legal Smalltalk:
				self foo
					ifTrue: [^self bar]
					ifFalse: [^self baz].
				^nil"
				^self].
		 stackp := joins at: pc]