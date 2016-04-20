initialize-release
knownVersionNumbers
	"Version numbers currently in use or likely to be used (e.g. 64-bit Cog formats)"

	"ImageFormat knownVersionNumbers collect: [:e | (ImageFormat fromInteger: e) description]"

	^ self baseVersionNumbers, "the original four variants"
		{
			6505 .	"Cog and StackVM"
			68003 .	"Cog and StackVM running 64-bit image"
			6521 .	"Spur 32 bit object memory"
			68019 .	"Spur 64 bit object memory (early)"
			68021 .	"Spur 64 bit object memory"
				" ... add others here as bits are allocated to represent requirements of other image formats"
		}
