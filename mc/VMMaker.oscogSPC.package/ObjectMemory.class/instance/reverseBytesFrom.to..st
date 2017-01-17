image save/restore
reverseBytesFrom: startAddr to: stopAddr
	"Byte-swap the given range of memory (not inclusive of stopAddr!)."
	| addr |
	addr := startAddr.
	[self oop: addr isLessThan: stopAddr] whileTrue:
		[self longAt: addr put: (self byteSwapped: (self longAt: addr)).
		addr := addr + self wordSize].