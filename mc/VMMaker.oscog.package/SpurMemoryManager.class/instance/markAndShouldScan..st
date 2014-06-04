gc - global
markAndShouldScan: objOop
	"Mark the argument, and answer if its fields should be scanned now.
	 Immediate objects don't need to be marked.
	 Already marked objects have already been processed.
	 Pure bits objects don't need scanning, although their class does.
	 Weak objects should be pushed on the weakling stack.
	 Anything else need scanning."
	| format |
	(self isImmediate: objOop) ifTrue:
		[^false].
	self assert: (self isForwarded: objOop) not.
	(self isMarked: objOop) ifTrue:
		[^false].
	self setIsMarkedOf: objOop to: true.
	format := self formatOf: objOop.
	(self isPureBitsFormat: format) ifTrue: "avoid pushing non-pointer objects on the markStack"
		[self markAndTraceClassOf: objOop.
		 ^false].
	format = self weakArrayFormat ifTrue: "push weaklings on the weakling stack to scan later"
		[self push: objOop onObjStack: weaklingStack.
		 ^false].
	^true