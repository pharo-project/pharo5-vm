compaction
atLeastClassIndexHalfHeader: obj
	"PRIVATE: For compaction, answer the bits contaning the
	 classIndex and isPinned bits in the most natural form."
	^self longAt: obj