debug support
compilationBreak: selectorOop point: selectorLength isMNUCase: isMNUCase
	<api>
	<cmacro: '(sel, len, isMNU) do { \
	if ((len) == (isMNU ? -breakSelectorLength : breakSelectorLength) \
	 && !strncmp((char *)((sel) + BaseHeaderSize), breakSelector, (isMNU ? -breakSelectorLength : breakSelectorLength))) { \
		suppressHeartbeatFlag = 1; \
		compilationBreakpointFor(sel); \
	} \
} while (0)'>
	| bsl i |
	bsl := isMNUCase ifTrue: [breakSelectorLength negated] ifFalse: [breakSelectorLength].
	bsl = selectorLength ifTrue:
		[i := bsl.
		 [i > 0] whileTrue:
			[(objectMemory byteAt: selectorOop + i + objectMemory baseHeaderSize - 1) = (breakSelector at: i) asInteger
				ifTrue: [(i := i - 1) = 0 ifTrue:
							[self compilationBreakpointFor: selectorOop]]
				ifFalse: [i := 0]]]