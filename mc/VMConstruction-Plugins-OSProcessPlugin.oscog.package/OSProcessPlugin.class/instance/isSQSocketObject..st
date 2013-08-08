private - SQSocket access
isSQSocketObject: objectPointer
	"Answer true if objectPointer appears to be a valid SQSocket ByteArray. This check
	is appropriate if objectPointer has been passed as a parameter to a primitive, and
	is expected to represent a valid socket reference."

	^ (((interpreterProxy isBytes: objectPointer)
		and: [(interpreterProxy byteSizeOf: objectPointer) = self socketRecordSize]))
		and: [(self isNullSQSocket: objectPointer) not]
