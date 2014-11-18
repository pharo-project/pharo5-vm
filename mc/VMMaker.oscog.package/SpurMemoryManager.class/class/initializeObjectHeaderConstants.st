class initialization
initializeObjectHeaderConstants

	BytesPerWord ifNil: [BytesPerWord := 4].  "May get called on fileIn, so supply default"
	BaseHeaderSize := 8. "This is still needed for VM generation."
	BytesPerOop := BytesPerWord