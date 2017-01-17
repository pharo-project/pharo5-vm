allocation
sufficientSpaceAfterGC: minFree 
	"Return true if there is enough free space after doing a garbage collection. If not, signal that space is low."
	<inline: false>
	| oldLimit |
	self incrementalGC. "try to recover some space"

	(self oop: freeStart + minFree isLessThanOrEqualTo: reserveStart) ifTrue:
		[^true].

	signalLowSpace ifTrue:
		[^false]. "give up; problem is already noted"

	self fullGC. "try harder"
	"for stability, require more free space after doing an expensive full GC"
	(self oop: freeStart + minFree + 15000 isLessThan: reserveStart) ifTrue:
		[^true].

	"still not enough; attempt to grow object memory"

	[oldLimit := memoryLimit.
	 self growObjectMemory: minFree + 15000 + growHeadroom.
	 self oop: freeStart + minFree + 15000 isLessThan: reserveStart]
		whileFalse: "If the memoryLimit doesn't change then presumably the platform can't grow anymore." 
			[oldLimit = memoryLimit ifTrue: [^false]].
	^true