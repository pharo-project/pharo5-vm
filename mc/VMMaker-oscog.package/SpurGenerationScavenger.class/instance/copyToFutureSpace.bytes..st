scavenger
copyToFutureSpace: survivor bytes: bytesInObject
	"Copy survivor to futureSpace.  Assume it will fit (checked by sender).
	 Answer the new oop of the object (it may have an overflow size field)."
	<inline: true>
	| startOfSurvivor newStart |
	self assert: futureSurvivorStart + bytesInObject <= futureSpace limit.
	startOfSurvivor := manager startOfObject: survivor.
	newStart := futureSurvivorStart.
	futureSurvivorStart := futureSurvivorStart + bytesInObject.
	manager mem: newStart cp: startOfSurvivor y: bytesInObject.
	^newStart + (survivor - startOfSurvivor)