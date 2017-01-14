debug support
mnuCompilationBreak: selectorOop point: selectorLength
	<api>
	<cmacro: '(sel, len) do { \
	if ((len) == -breakSelectorLength \
	 && !strncmp((char *)((sel) + BaseHeaderSize), breakSelector, -breakSelectorLength)) { \
		suppressHeartbeatFlag = 1; \
		compilationBreakpointFor(sel); \
	} \
} while (0)'>
	| i |
	breakSelectorLength negated = selectorLength ifTrue:
		[i := breakSelectorLength negated.
		 [i > 0] whileTrue:
			[(objectMemory byteAt: selectorOop + i + objectMemory baseHeaderSize - 1) = (breakSelector at: i) asInteger
				ifTrue: [(i := i - 1) = 0 ifTrue:
							[self mnuCompilationBreakpointFor: selectorOop]]
				ifFalse: [i := 0]]]