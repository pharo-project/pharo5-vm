testing
testBitsInUse
	"Ensure that the list of known version numbers is kept up to date with the bit allocation"

	| allocatedBitsInUse calculatedBitsInUse |
	calculatedBitsInUse := ImageFormat knownVersionNumbers
		inject: 0
		into: [ :e :a | a bitOr: e] .
	allocatedBitsInUse := ImageFormat baseVersionMask bitOr: ImageFormat capabilitiesBitsMask.
	self assert: calculatedBitsInUse = allocatedBitsInUse
