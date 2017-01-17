interpreter access
instanceSizeOf: classObj
	<api>
	"Answer the number of slots in a class.  For example the instanceSizeOf: 
	 ClassPoint is 2, for the x & y slots. The instance size of non-pointer classes is 0."
	| classHdr sizeHiBits byteSize |
	self assert: (self addressCouldBeObj: classObj).

	classHdr := self formatOfClass: classObj. "Low 2 bits are 0"

	"Compute the size of instances of the class (used for fixed field classes only)"
	sizeHiBits := classHdr >> 9 bitAnd: 16r300.
	byteSize := (classHdr bitAnd: SizeMask) + sizeHiBits. "size in bytes -- low 2 bits are 0"
	^byteSize - self baseHeaderSize / self wordSize