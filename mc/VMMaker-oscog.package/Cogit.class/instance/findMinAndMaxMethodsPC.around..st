method map
findMinAndMaxMethodsPC: blockEntryPC around: mcpc
	<returnTypeC: #usqInt>
	(blockEntryPC asUnsignedInteger <= mcpc asUnsignedInteger
	and: [blockEntryPC asUnsignedInteger > maxMethodBefore asUnsignedInteger]) ifTrue:
		[maxMethodBefore := self cCoerceSimple: blockEntryPC - (self sizeof: CogBlockMethod)
								   to: #'CogBlockMethod *'].
	^0 "keep scanning..."