gc -- mark and sweep
initWeakTableForIncrementalGC: trueIfIncrementalGC
	"The weakRoots table is only used for incrementalGC.
	 Enable it by setting weakRootCount to 0.
	 Disable it by making it negative."
	weakRootCount := trueIfIncrementalGC ifTrue: [0] ifFalse: [-1]