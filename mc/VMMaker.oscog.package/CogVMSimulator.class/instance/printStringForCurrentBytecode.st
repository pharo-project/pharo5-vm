debug printing
printStringForCurrentBytecode
	^String streamContents: [:str| self printCurrentBytecodeOn: str]