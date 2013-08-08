private - SQFile access
isSQFileObject: objectPointer 
	"Answer true if objectPointer appears to be a valid SQFile ByteArray.
	This check is appropriate if objectPointer has been passed as a parameter
	to a primitive, and is expected to represent a valid file reference."

	^ (((interpreterProxy isBytes: objectPointer)
		and: [(interpreterProxy byteSizeOf: objectPointer) = self fileRecordSize])
		and: [self isValidFileSession: objectPointer])
		and: [self isNonNullSQFile: objectPointer]