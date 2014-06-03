debug support
compilationBreak: selectorOop point: selectorLength
	<api>
	<cmacro: '(sel, len) do { \
	if ((len) == breakSelectorLength \
	 && !strncmp((char *)((sel) + BaseHeaderSize), breakSelector, breakSelectorLength)) { \
		suppressHeartbeatFlag = 1; \
		compilationBreakpointFor(sel); \
	} \
} while (0)'>
	| i |
	breakSelectorLength = selectorLength ifTrue:
		[i := breakSelectorLength.
		 [i > 0] whileTrue:
			[(objectMemory byteAt: selectorOop + i + BaseHeaderSize - 1) = (breakSelector at: i) asInteger
				ifTrue: [(i := i - 1) = 0 ifTrue:
							[self compilationBreakpointFor: selectorOop]]
				ifFalse: [i := 0]]]