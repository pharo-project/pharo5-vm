snapshot
reverseBytesIn32BitWordsFrom: startAddr to: stopAddr
	"Byte-swap the given range of memory (not inclusive of stopAddr!)."
	| addr |
	addr := startAddr.
	[self oop: addr isLessThan: stopAddr] whileTrue:
		[self long32At: addr put: ((self long32At: addr) byteSwap32).
		 addr := addr + 4]