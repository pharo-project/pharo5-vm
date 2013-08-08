private - SQFile access
newSQFileByteArray
	"Answer a new ByteArray sized to contain a SQFile data structure."

	^ interpreterProxy
		instantiateClass: interpreterProxy classByteArray
		indexableSize: self fileRecordSize
