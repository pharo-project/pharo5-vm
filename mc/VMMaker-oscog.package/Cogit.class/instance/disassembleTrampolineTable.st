debugging
disassembleTrampolineTable
	<doNotGenerate>
	0 to: trampolineTableIndex - 1 by: 2 do:
		[:i|
		self disassembleTrampolineFor: (trampolineAddresses at: i + 1) asInteger.
		coInterpreter transcript cr]