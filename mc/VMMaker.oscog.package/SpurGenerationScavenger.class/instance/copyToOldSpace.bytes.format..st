scavenger
copyToOldSpace: survivor bytes: bytesInObject format: formatOfSurvivor
	"Copy survivor to oldSpace.  Answer the new oop of the object."
	<inline: #never> "Should be too infrequent to lower icache density of copyAndForward:"
	| nTenures startOfSurvivor newStart newOop |
	self assert: (formatOfSurvivor = (manager formatOf: survivor)
				and: [((manager isMarked: survivor) not or: [tenureCriterion = MarkOnTenure])
				and: [tenureCriterion = TenureToShrinkRT
					or: [(manager isPinned: survivor) not
						and: [(manager isRemembered: survivor) not]]]]).
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
	tenureCriterion >= (TenureToShrinkRT min: MarkOnTenure) ifTrue:
		[tenureCriterion = TenureToShrinkRT ifTrue:
			[manager rtRefCountOf: newOop put: 0].
		 tenureCriterion = MarkOnTenure ifTrue:
			[manager setIsMarkedOf: newOop to: true]].
	statTenures := nTenures + 1.
	(manager isAnyPointerFormat: formatOfSurvivor) ifTrue:
		["A very quick and dirty scan to find young referents.  If we misidentify bytes
		  in a CompiledMethod as young we don't care; it's unlikely, and a subsequent
		  scan of the rt will filter the object out.  But it's good to filter here because
		  otherwise an attempt to shrink the RT may simply fill it up with new objects,
		  and here the data is likely in the cache."
		 manager baseHeaderSize to: bytesInObject - (survivor - startOfSurvivor) - manager wordSize by: manager wordSize do:
			[:p| | field |
			field := manager longAt: survivor + p.
			(manager isReallyYoung: field) ifTrue:
				[self remember: newOop.
				 ^newOop]]].
	^newOop