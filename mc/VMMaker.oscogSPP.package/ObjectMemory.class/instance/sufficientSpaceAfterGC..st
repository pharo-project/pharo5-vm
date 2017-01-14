allocation
sufficientSpaceAfterGC: minFree 
	"Return true if there is enough free space after doing a garbage collection. If not, signal that space is low."
	| growSize |
	<inline: false>

	self incrementalGC. "try to recover some space"

	(self oop: (self sizeOfFree: freeBlock) isLessThan: minFree)
		ifTrue: [signalLowSpace ifTrue: [^false]. "give up; problem is already noted"
			self fullGC. "try harder"
			"for stability, require more free space after doing an expensive full GC"
			(self cCoerce: (self sizeOfFree: freeBlock) to: 'usqInt ') >= ((self cCoerce: minFree to: 'usqInt ') + 15000) ifTrue: [^ true].

			"still not enough; attempt to grow object memory"
			growSize := minFree - (self sizeOfFree: freeBlock) + growHeadroom.
			self growObjectMemory: growSize.

			(self oop: (self sizeOfFree: freeBlock) isGreaterThanOrEqualTo: minFree + 15000)
				ifTrue: [^true].

			"still not enough"
			^false].
	^true