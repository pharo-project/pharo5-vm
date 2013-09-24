class initialization
initializeObjectHeaderConstants

	BytesPerWord ifNil: [BytesPerWord := 4].  "May get called on fileIn, so supply default"
	BaseHeaderSize := 8 "Alas so much of the VM uses BaseheaderSize explicitly we don't (yet) make it a message."