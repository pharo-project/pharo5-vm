initialization
newSpaceStart: startAddress newSpaceBytes: totalBytes survivorBytes: requestedSurvivorBytes
	| actualEdenBytes survivorBytes |
	survivorBytes := requestedSurvivorBytes truncateTo: manager allocationUnit.
	actualEdenBytes := totalBytes - survivorBytes - survivorBytes truncateTo: manager allocationUnit.
	self assert: totalBytes - actualEdenBytes - survivorBytes - survivorBytes < manager allocationUnit.

	"for tenuring we require older objects below younger objects.  since allocation
	 grows up this means that the survivor spaces must precede eden."

	pastSpace start: startAddress; limit: startAddress + survivorBytes.
	futureSpace start: pastSpace limit; limit: pastSpace limit + survivorBytes.
	eden start: futureSpace limit; limit: startAddress + totalBytes.

	self assert: self futureSpace limit <= (startAddress + totalBytes).
	self assert: self eden start \\ manager allocationUnit
				+ (self eden limit \\ manager allocationUnit) = 0.
	self assert: self pastSpace start \\ manager allocationUnit
				+ (self pastSpace limit \\ manager allocationUnit) = 0.
	self assert: self futureSpace start \\ manager allocationUnit
				+ (self futureSpace limit \\ manager allocationUnit) = 0.

	self initFutureSpaceStart.
	manager initSpaceForAllocationCheck: (self addressOf: eden) limit: eden limit.

	tenuringProportion := 0.9