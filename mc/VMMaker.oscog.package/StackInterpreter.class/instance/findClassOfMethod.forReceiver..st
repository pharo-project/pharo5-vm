debug support
findClassOfMethod: meth forReceiver: rcvr
	| rclass mclass |
	((objectMemory addressCouldBeOop: rcvr)
	and: [(objectMemory isOopForwarded: rcvr) not]) ifTrue:
		[rclass := objectMemory fetchClassOf: rcvr.
		 (self addressCouldBeClassObj: rclass) ifTrue:
			[rclass := self findClassContainingMethod: meth startingAt: rclass.
			rclass ~= objectMemory nilObject ifTrue:
				[^rclass]]].
	((objectMemory addressCouldBeObj: meth)
	 and: [objectMemory isCompiledMethod: meth]) ifFalse:
		[^objectMemory nilObject].
	mclass := self safeMethodClassOf: meth.
	(self addressCouldBeClassObj: mclass) ifTrue:
		[^objectMemory nilObject].
	^self findClassContainingMethod: meth startingAt: (self safeMethodClassOf: meth)