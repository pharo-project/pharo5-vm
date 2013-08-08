subclass responsibilities
frameCount: aByteArray
	"Compute the frame count for this byteArray.  This default computation will have to be overridden by codecs with variable frame sizes."

	^ (ReadStream on: aByteArray) nextNumber: 4.
