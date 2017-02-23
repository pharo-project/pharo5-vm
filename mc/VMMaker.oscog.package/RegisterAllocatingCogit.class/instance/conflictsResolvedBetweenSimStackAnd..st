bytecode generator support
conflictsResolvedBetweenSimStackAnd: mergeSimStack 
	"There are no register conflicts between simStack and mergeSimStack if
	 traversing both stacks from hot end (simStackPtr) to cold end (0) no register
	 exists in simStack that has previously existed in mergeSimStack.  This is because
	 the resolution assigns values from simStack to registers in mergeSimStack and so
	 must not assign to a register yet to be read."
	 | regsWrittenToMask |
	regsWrittenToMask := 0.
	simStackPtr to: 0 by: -1 do:
		[:i| | mergeMask currentMask |
		mergeMask := (self simStack: mergeSimStack at: i) registerMaskOrNone.
		currentMask := (self simStack: simStack at: i) registerMaskOrNone.
		mergeMask ~= currentMask ifTrue:
			[(currentMask anyMask: regsWrittenToMask) ifTrue:
				[^false]].
		regsWrittenToMask := regsWrittenToMask bitOr: mergeMask].
	^true