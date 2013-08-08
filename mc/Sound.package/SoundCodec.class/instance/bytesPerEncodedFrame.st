subclass responsibilities
bytesPerEncodedFrame
	"Answer the number of bytes required to hold one frame of compressed sound data. Answer zero if this codec produces encoded frames of variable size."

	self subclassResponsibility.
