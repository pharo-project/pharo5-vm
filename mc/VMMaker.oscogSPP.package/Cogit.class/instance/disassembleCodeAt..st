disassembly
disassembleCodeAt: pc
	<doNotGenerate>
	(pc between: (trampolineAddresses at: 1) and: methodZoneBase - 1) ifTrue:
		[^self disassembleTrampolineFor: pc].
	self disassembleMethodFor: pc