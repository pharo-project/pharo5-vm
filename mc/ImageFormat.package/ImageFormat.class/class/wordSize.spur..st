instance creation
wordSize: bytesPerWord spur: spurRequired
	"Answer a Spur image format, or default to Cog if Spur is not specified"

	| update64 |
	update64 := bytesPerWord == 8. "The 64 bit Spur image has an updated version"
	^self wordSize: bytesPerWord spur: spurRequired requiresNewSpur64TagAssignment: update64