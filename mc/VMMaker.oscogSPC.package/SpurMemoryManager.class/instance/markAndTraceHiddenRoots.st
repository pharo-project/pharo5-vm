gc - global
markAndTraceHiddenRoots
	"The hidden roots hold both the class table pages and the obj stacks,
	 and hence need special treatment.  The obj stacks must be marked
	 specially; their pages must be marked, but only the contents of the
	 mournQueue should be marked.

	 If a class table page is weak we can mark and trace the hiddenRoots,
	 which will not trace through class table pages because they are weak.
	 But if class table pages are strong, we must mark the pages and *not*
	 trace them so that only classes reachable from the true roots will be
	 marked, and unreachable classes will be left unmarked."

	self markAndTraceObjStack: markStack andContents: false.
	self markAndTraceObjStack: weaklingStack andContents: false.
	self markAndTraceObjStack: mournQueue andContents: true.

	self setIsMarkedOf: self rememberedSetObj to: true.
	self setIsMarkedOf: self freeListsObj to: true.

	(self isWeakNonImm: classTableFirstPage) ifTrue:
		[^self markAndTrace: hiddenRootsObj].

	self setIsMarkedOf: hiddenRootsObj to: true.
	self markAndTrace: classTableFirstPage.
	1 to: numClassTablePages - 1 do:
		[:i| self setIsMarkedOf: (self fetchPointer: i ofObject: hiddenRootsObj)
				to: true]