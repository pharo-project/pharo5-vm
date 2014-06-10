*VMMaker-support
detailedSymbolic
	^String streamContents: [:s| (DetailedInstructionPrinter on: self) printInstructionsOn: s]