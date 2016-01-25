scavenger
copyToFutureSpace: survivor bytes: bytesInObject
	"Copy survivor to futureSpace.  Assume it will fit (checked by sender).
	 Answer the new oop of the object (it may have an overflow size field)."
	<inline: true>
	| startOfSurvivor newStart |
	statSurvivorCount := statSurvivorCount + 1. "we hope writes are cheap..."
	self assert: futureSurvivorStart + bytesInObject <= futureSpace limit.
	startOfSurvivor := manager startOfObject: survivor.
	newStart := futureSurvivorStart.
	futureSurvivorStart := futureSurvivorStart + bytesInObject.
	manager mem: newStart asVoidPointer cp: startOfSurvivor asVoidPointer y: bytesInObject.
	tenureCriterion = TenureToShrinkRT ifTrue:
		[manager rtRefCountOf: newStart + (survivor - startOfSurvivor) put: 0].
	^newStart + (survivor - startOfSurvivor)