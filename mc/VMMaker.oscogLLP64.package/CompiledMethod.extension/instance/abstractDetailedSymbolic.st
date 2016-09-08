*VMMaker-support
abstractDetailedSymbolic
	^String streamContents: [:s| (RelativeDetailedInstructionPrinter on: self) printInstructionsOn: s]