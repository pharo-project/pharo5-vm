private - SQSocket access
newSQSocketByteArray
	"Answer a new ByteArray sized to contain a SQSocket data structure."

	^ interpreterProxy
		instantiateClass: interpreterProxy classByteArray
		indexableSize: self socketRecordSize
