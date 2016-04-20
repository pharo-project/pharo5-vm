initialize-release
initialize
	"ImageFormat initialize"

	PlatformByteOrderBit := 1.
	SpurObjectBit := 5.
	BaseVersionNumbers := self baseVersionNumbers.
	BaseVersionMask := self baseVersionMask.
	CapabilitiesBitsMask := self capabilitiesBitsMask.
	ReservedBitsMask := self availableBits.
	KnownVersionNumbers := self knownVersionNumbers.
