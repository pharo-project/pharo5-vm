private
check: obj
	<inline: true>
	self cCode: '' inSmalltalk: [obj = interestingObj ifTrue: [self halt]].
	"this debugged the misuse of the largest free chunk:"
	"(manager checkForLeaks bitAnd: GCModeFull+GCModeFreeSpace) = GCModeFull ifTrue:
		[self deny: ((manager isEnumerableObject: obj) and: [(manager heapMapAtWord: obj) = 0])]"