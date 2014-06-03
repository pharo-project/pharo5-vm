disassembly
disassembleTrampolineFor: pc
	<doNotGenerate>
	| limit |
	limit := methodZoneBase - 1.
	pc > methodZoneBase ifTrue: [^self].
	trampolineTableIndex - 1 to: 0 by: -2 do:
		[:i| | addr |
		pc >= (addr := (trampolineAddresses at: i) asInteger) ifTrue:
			[^self disassembleFrom: addr to: limit].
		limit := addr - 1]