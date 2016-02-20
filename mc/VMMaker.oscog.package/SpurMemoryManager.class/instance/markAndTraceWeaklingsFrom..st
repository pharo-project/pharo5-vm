weakness and ephemerality
markAndTraceWeaklingsFrom: startIndex
	"Mark weaklings on the weaklingStack, ignoring startIndex
	 number of elements on the bottom of the stack.  Answer
	 the size of the stack *before* the enumeration began."
	^self objStack: weaklingStack from: startIndex do:
		[:weakling|
		 self deny: (self isForwarded: weakling).
		 self markAndTraceClassOf: weakling.
		"N.B. generateToByDoLimitExpression:negative:on: guards against (unsigned)0 - 1 going +ve"
		 0 to: (self numStrongSlotsOfWeakling: weakling) - 1 do:
			[:i| | field |
			field := self followOopField: i ofObject: weakling.
			((self isImmediate: field) or: [self isMarked: field]) ifFalse:
				[self markAndTrace: field]]]