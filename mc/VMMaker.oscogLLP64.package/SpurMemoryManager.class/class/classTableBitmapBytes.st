accessing
classTableBitmapBytes
	"Max size of the classTableBitmap.  A liottle too large to contemplate allocating statically."
	^1 << (self basicNew classIndexFieldWidth - (BitsPerByte log: 2) asInteger)