initialization
newSpaceStart: startAddress newSpaceBytes: totalBytes edenBytes: requestedEdenBytes 
	| actualEdenBytes survivorBytes |

	actualEdenBytes := requestedEdenBytes.
	survivorBytes := totalBytes - actualEdenBytes // 2 truncateTo: manager allocationUnit.
	actualEdenBytes := totalBytes - survivorBytes - survivorBytes truncateTo: manager allocationUnit.
	self assert: totalBytes - actualEdenBytes - survivorBytes - survivorBytes < manager allocationUnit.

	"for tenuring we require older objects below younger objects.  since allocation
	 grows up this means that the survivor spaces must preceed eden."

	pastSpace start: startAddress; limit: startAddress + survivorBytes.
	futureSpace start: pastSpace limit; limit: pastSpace limit + survivorBytes.
	eden start: futureSpace limit; limit: futureSpace limit + actualEdenBytes.

	self assert: futureSpace limit <= (startAddress + totalBytes).
	self assert: eden start \\ manager allocationUnit
				+ (eden limit \\ manager allocationUnit) = 0.
	self assert: pastSpace start \\ manager allocationUnit
				+ (pastSpace limit \\ manager allocationUnit) = 0.
	self assert: futureSpace start \\ manager allocationUnit
				+ (futureSpace limit \\ manager allocationUnit) = 0.

	self initFutureSpaceStart.
	manager initSpaceForAllocationCheck: (self addressOf: eden) limit: eden limit.

	tenuringProportion := 0.9