image save/restore
reverseWordsFrom: startAddr to: stopAddr
	"Word-swap the given range of memory, excluding stopAddr."

	| addr |
	addr := startAddr.
	[self oop: addr isLessThan: stopAddr] whileTrue:
		[self longAt: addr put: (self wordSwapped: (self longAt: addr)).
		addr := addr + self wordSize].