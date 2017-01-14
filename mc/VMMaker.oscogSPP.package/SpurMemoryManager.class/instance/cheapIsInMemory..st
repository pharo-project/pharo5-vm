plugin support
cheapIsInMemory: address
	"Answer if the given address is in ST object memory.  For simulation only."
	<doNotGenerate>
	^address >= newSpaceStart and: [address < endOfMemory]