header format
baseHeaderSize
	"Object headers are 8 bytes in length if the slot size fits in the slot size field (max implies overflow),
	 16 bytes otherwise (slot size in preceding word)."
	^8