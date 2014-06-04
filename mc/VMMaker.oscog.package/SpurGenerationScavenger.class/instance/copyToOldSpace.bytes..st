scavenger
copyToOldSpace: survivor bytes: bytesInObject
	"Copy survivor to oldSpace.  Answer the new oop of the object."
	<inline: true>
	| nTenures startOfSurvivor newStart newOop |
	nTenures := statTenures.
	startOfSurvivor := manager startOfObject: survivor.
	newStart := manager allocateOldSpaceChunkOfBytes: bytesInObject.
	newStart ifNil:
		[manager growOldSpaceByAtLeast: 0. "grow by growHeadroom"
		 newStart := manager allocateOldSpaceChunkOfBytes: bytesInObject.
		 newStart ifNil:
			[self error: 'out of memory']].
	manager checkFreeSpace.
	manager mem: newStart asVoidPointer cp: startOfSurvivor asVoidPointer y: bytesInObject.
	newOop := newStart + (survivor - startOfSurvivor).
	(manager hasPointerFields: survivor) ifTrue:
		[self remember: newOop.
		 manager setIsRememberedOf: newOop to: true].
	statTenures := nTenures + 1.
	^newOop