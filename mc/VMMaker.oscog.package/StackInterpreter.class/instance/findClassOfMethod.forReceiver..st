debug support
findClassOfMethod: meth forReceiver: rcvr
	((objectMemory addressCouldBeOop: rcvr)
	and: [(objectMemory isOopForwarded: rcvr) not]) ifTrue:
		[| rclass |
		 rclass := self
					findClassContainingMethod: meth
					startingAt: (objectMemory fetchClassOf: rcvr).
		 rclass ~= objectMemory nilObject ifTrue:
			[^rclass]].
	((objectMemory addressCouldBeObj: meth)
	 and: [objectMemory isCompiledMethod: meth]) ifFalse:
		[^objectMemory nilObject].
	^self
		findClassContainingMethod: meth
		startingAt: (self safeMethodClassOf: meth)