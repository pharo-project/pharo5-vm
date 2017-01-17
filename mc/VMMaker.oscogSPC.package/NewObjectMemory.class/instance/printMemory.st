debug printing
printMemory
	self printMemField: self startOfMemory name: 'memory      ' size: youngStart - self startOfMemory.
	self printMemField: youngStart name: 'youngStart  ' size: freeStart - youngStart.
	freeStart <= scavengeThreshold
		ifTrue:
			[self printMemField: freeStart name: 'freeStart   ' size: reserveStart - freeStart.
			 self printMemField: scavengeThreshold name: 'scavenge@   ' size: scavengeThreshold-freeStart]
		ifFalse:
			[self printMemField: scavengeThreshold name: 'scavenge@   ' size: scavengeThreshold-freeStart.
			 self printMemField: freeStart name: 'freeStart   ' size: reserveStart - freeStart].
	self printMemField: reserveStart name: 'reserveStart' size: endOfMemory - reserveStart.
	self printMemField: endOfMemory name: 'endOfMemory ' size: memoryLimit - endOfMemory.
	self printMemField: memoryLimit name: 'memoryLimit ' size: 0