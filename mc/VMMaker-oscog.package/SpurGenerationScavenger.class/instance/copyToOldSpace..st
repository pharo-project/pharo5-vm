scavenger
copyToOldSpace: survivor
	"Copy survivor to oldSpace.  Answer the new oop of the object."
	<inline: true>
	| numSlots newOop |
	self flag: 'why not just pass header??'.
	numSlots := manager numSlotsOf: survivor.
	newOop := manager
					allocateSlotsInOldSpace: numSlots
					format: (manager formatOf: survivor)
					classIndex: (manager classIndexOf: survivor).
	newOop ifNil:
		[self error: 'out of memory'].
	manager
		mem: newOop + manager baseHeaderSize
		cp: survivor + manager baseHeaderSize
		y: numSlots * manager wordSize.
	self remember: newOop.
	manager setIsRememberedOf: newOop to: true.
	^newOop