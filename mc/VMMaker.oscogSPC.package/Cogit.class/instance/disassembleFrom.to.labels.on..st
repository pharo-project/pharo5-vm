disassembly
disassembleFrom: startAddress to: endAddress labels: labelDictionary on: aStream
	<doNotGenerate>
	aStream ensureCr.
	processor disassembleFrom: startAddress to: endAddress in: coInterpreter memory for: self labels: labelDictionary on: aStream.
	aStream flush