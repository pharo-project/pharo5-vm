full transfer run-time support
disassembleOn: aStream
	<doNotGenerate>
	cogit processor
		disassembleFrom: 0
		to: machineCodeSize - 1
		in: machineCode object
		on: aStream