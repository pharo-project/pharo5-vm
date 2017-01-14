disassembly
labelForPC: address
	<doNotGenerate>
	^address < methodZoneBase ifTrue:
		[self lookupAddress: address]