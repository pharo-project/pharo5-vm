scavenger
copyToOldSpace: survivor
	"Copy survivor to oldSpace.  Answer the new oop of the object."
	<inline: true>
	| nTenures numSlots hash newOop |
	nTenures := statTenures.
	self flag: 'why not just pass header??'.
	numSlots := manager numSlotsOf: survivor.
	hash := manager rawHashBitsOf: survivor.
	newOop := manager
					allocateSlotsInOldSpace: numSlots
					format: (manager formatOf: survivor)
					classIndex: (manager classIndexOf: survivor).
	newOop ifNil:
		[manager growOldSpaceByAtLeast: 0. "grow by growHeadroom"
		 newOop := manager
					allocateSlotsInOldSpace: numSlots
					format: (manager formatOf: survivor)
					classIndex: (manager classIndexOf: survivor).
		 newOop ifNil:
			[self error: 'out of memory']].
	manager
		mem: (newOop + manager baseHeaderSize) asVoidPointer
		cp: (survivor + manager baseHeaderSize) asVoidPointer
		y: numSlots * manager wordSize.
	(manager hasPointerFields: survivor) ifTrue:
		[self remember: newOop.
		 manager setIsRememberedOf: newOop to: true].
	hash ~= 0 ifTrue:
		[manager setHashBitsOf: newOop to: hash].
	statTenures := nTenures + 1.
	^newOop