gc - global
markAccessibleObjectsAndFireEphemerons
	self assert: marking.
	self assert: self validClassTableRootPages.
	self assert: segmentManager allBridgesMarked.
	self cCode: [] "for debugging markAndTrace: set (MarkStackRecord := OrderedCollection new)"
		inSmalltalk: [MarkStackRecord ifNotNil: [MarkStackRecord resetTo: 1]].

	"This must come first to enable stack page reclamation.  It clears
	  the trace flags on stack pages and so must precede any marking.
	  Otherwise it will clear the trace flags of reached pages."
	coInterpreter initStackPageGC.
	self markAndTraceHiddenRoots.
	self markAndTraceExtraRoots.
	self assert: self validClassTableRootPages.
	coInterpreter markAndTraceInterpreterOops: true.
	self assert: self validObjStacks.
	self markWeaklingsAndMarkAndFireEphemerons.
	self assert: self validObjStacks