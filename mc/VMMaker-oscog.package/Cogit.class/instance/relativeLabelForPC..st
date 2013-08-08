disassembly
relativeLabelForPC: pc 
	<doNotGenerate>
	pc < methodZone limitZony ifFalse:
		[^nil].
	pc < methodZoneBase ifTrue:
		[^(self codeEntryNameFor: pc) ifNotNil:
			[:name| name, '+', (pc - (self codeEntryFor: pc)) printString]].
	^self lookupAddress: pc