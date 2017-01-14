object enumeration
bytesInObject: objOop
	"Answer the total number of bytes in an object including header and possible overflow size header."
	self subclassResponsibility