accessing fills
topFillDepthPut: value
	^self stackFillDepth: self stackFillSize - self stackFillEntryLength put: value