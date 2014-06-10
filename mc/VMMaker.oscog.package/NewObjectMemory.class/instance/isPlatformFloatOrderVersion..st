image segment in/out
isPlatformFloatOrderVersion: imageVersion
	"Answer if floats are stored in the platform's float order for the given imageVersion.
	 Prior to this version they were always in big-endian (e.g. PowerPC) format."
	^imageVersion >= 6505