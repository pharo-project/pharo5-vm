method map
findBlockMethodWithEntry: blockEntryMcpc startBcpc: startBcpc
	<returnTypeC: #usqInt>
	| cogBlockMethod |
	<var: #cogBlockMethod type: #'CogBlockMethod *'>
	cogBlockMethod := self cCoerceSimple: blockEntryMcpc - (self sizeof: CogBlockMethod)
							  to: #'CogBlockMethod *'.
	cogBlockMethod startpc = startBcpc ifTrue:
		[^cogBlockMethod asUnsignedInteger].
	^0 "keep scanning..."