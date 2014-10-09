gc - global
markAndShouldScan: objOop
	"Helper for markAndTrace:.
	 Mark the argument, and answer if its fields should be scanned now.
	 Immediate objects don't need to be marked.
	 Already marked objects have already been processed.
	 Pure bits objects don't need scanning, although their class does.
	 Weak objects should be pushed on the weakling stack.
	 Anything else need scanning."
	| format |
	<inline: true>
	(self isImmediate: objOop) ifTrue:
		[^false].
	"if markAndTrace: is to follow and eliminate forwarding pointers
	 in its scan it cannot be handed an r-value which is forwarded."
	self assert: (self isForwarded: objOop) not.
	(self isMarked: objOop) ifTrue:
		[^false].
	self setIsMarkedOf: objOop to: true.
	format := self formatOf: objOop.
	(self isPureBitsFormat: format) ifTrue: "avoid pushing non-pointer objects on the markStack."
		["Avoid tracing classes of non-objects on the heap, e.g. IRC caches, Sista counters."
		 (self classIndexOf: objOop) > self lastClassIndexPun ifTrue:
			[self markAndTraceClassOf: objOop].
		 ^false].
	format = self weakArrayFormat ifTrue: "push weaklings on the weakling stack to scan later"
		[self push: objOop onObjStack: weaklingStack.
		 ^false].
	(format = self ephemeronFormat
	 and: [self activeAndDeferredScan: objOop]) ifTrue:
		[^false].
	^true