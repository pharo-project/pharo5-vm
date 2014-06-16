image formats
capabilitiesBitsMask
	"Bits currently used as capability bits."
	
	"ImageFormat capabilitiesBitsMask printStringBase: 2"

	^ (0 bitAt: PlatformByteOrderBit put: 1)
		bitAt: SpurObjectBit put: 1
