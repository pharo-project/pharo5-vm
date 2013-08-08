instance creation
new: byteSize
	"Answer a new instance of the given byte size whose data resides on trhe Smalltalk heap directly in the instance."
	^(self basicNew: self sizeofLong + byteSize )
		sizeFieldPut: byteSize;
		initialize