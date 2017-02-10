private
check: obj
	<inline: true>
	sffsMode ifNotNil: [self deny: ((manager isGrey: obj) or: [(manager isImmutable: obj)  or: [manager isRemembered: obj]])].
	obj = interestingObj ifTrue: [self halt].
	"this debugged the misuse of the largest free chunk:"
	"(manager checkForLeaks bitAnd: GCModeFull+GCModeFreeSpace) = GCModeFull ifTrue:
		[self deny: ((manager isEnumerableObject: obj) and: [(manager heapMapAtWord: obj) = 0])]"