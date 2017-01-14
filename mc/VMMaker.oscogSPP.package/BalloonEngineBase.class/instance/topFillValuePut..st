accessing fills
topFillValuePut: value
	^self stackFillValue: self stackFillSize - self stackFillEntryLength put: value