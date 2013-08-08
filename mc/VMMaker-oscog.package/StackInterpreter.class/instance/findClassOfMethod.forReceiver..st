debug support
findClassOfMethod: meth forReceiver: rcvr
	| rclass |
	(objectMemory addressCouldBeOop: rcvr) ifTrue:
		[rclass := objectMemory fetchClassOf: rcvr.
		 (self addressCouldBeClassObj: rclass) ifTrue:
			[rclass := self findClassContainingMethod: meth startingAt: rclass.
			rclass ~= objectMemory nilObject ifTrue:
				[^rclass]]].
	((objectMemory addressCouldBeObj: meth)
	 and: [self isCompiledMethod: meth]) ifFalse:
		[^objectMemory nilObject].
	^self findClassContainingMethod: meth startingAt: (self methodClassOf: meth)