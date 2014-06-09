scavenger
copyToOldSpace: survivor bytes: bytesInObject format: formatOfSurvivor
	"Copy survivor to oldSpace.  Answer the new oop of the object."
	<inline: true>
	| nTenures startOfSurvivor newStart newOop |
	self assert: (formatOfSurvivor = (manager formatOf: survivor)
				and: [((manager isMarked: survivor) not or: [tenureCriterion = MarkOnTenure])
				and: [(manager isPinned: survivor) not
				and: [(manager isRemembered: survivor) not]]]).
	nTenures := statTenures.
	startOfSurvivor := manager startOfObject: survivor.
	newStart := manager allocateOldSpaceChunkOfBytes: bytesInObject.
	newStart ifNil:
		[manager growOldSpaceByAtLeast: 0. "grow by growHeadroom"
		 newStart := manager allocateOldSpaceChunkOfBytes: bytesInObject.
		 newStart ifNil:
			[self error: 'out of memory']].
	"manager checkFreeSpace."
	manager mem: newStart asVoidPointer cp: startOfSurvivor asVoidPointer y: bytesInObject.
	newOop := newStart + (survivor - startOfSurvivor).
	(manager isAnyPointerFormat: formatOfSurvivor) ifTrue:
		[self remember: newOop.
		 manager setIsRememberedOf: newOop to: true].
	tenureCriterion = MarkOnTenure ifTrue:
		[manager setIsMarkedOf: newOop to: true].
	statTenures := nTenures + 1.
	^newOop