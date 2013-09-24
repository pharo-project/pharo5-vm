initialization
manager: aSpurMemoryManager newSpaceStart: startAddress newSpaceBytes: totalBytes edenBytes: requestedEdenBytes 
	| edenBytes survivorBytes |
	manager := aSpurMemoryManager.

	edenBytes := requestedEdenBytes.
	survivorBytes := totalBytes - edenBytes // 2 truncateTo: manager allocationUnit.
	edenBytes := totalBytes - survivorBytes - survivorBytes truncateTo: manager allocationUnit.
	self assert: totalBytes - edenBytes - survivorBytes - survivorBytes < manager allocationUnit.

	"for tenuring we require older objects below younger objects.  since allocation
	 grows up this means that the survivor spaces must preceed eden."
	pastSpace := SpurNewSpaceSpace new.
	futureSpace := SpurNewSpaceSpace new.
	eden := SpurNewSpaceSpace new.

	pastSpace start: startAddress limit: startAddress + survivorBytes.
	futureSpace start: pastSpace limit limit: pastSpace limit + survivorBytes.
	eden start: futureSpace limit limit: futureSpace limit + edenBytes.

	self assert: futureSpace limit <= (startAddress + totalBytes).
	self assert: eden start \\ manager allocationUnit
				+ (eden limit \\ manager allocationUnit) = 0.
	self assert: pastSpace start \\ manager allocationUnit
				+ (pastSpace limit \\ manager allocationUnit) = 0.
	self assert: futureSpace start \\ manager allocationUnit
				+ (futureSpace limit \\ manager allocationUnit) = 0.

	self initFutureSpaceStart.
	self initPastSpaceForObjectEnumeration.
	manager initSpaceForAllocationCheck: eden