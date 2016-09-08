UI
byteCountText
	^(String streamContents: [:s| s print: byteCount; nextPut: $/; print: sendCount]) asText