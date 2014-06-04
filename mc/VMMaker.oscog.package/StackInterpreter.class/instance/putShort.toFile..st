image save/restore
putShort: aShort toFile: aFile
	"Append the 16-bit aShort to aFile in this platforms 'natural' byte order.
	 (Bytes will be swapped, if necessary, when the image is read on a
	 different platform.) Set successFlag to false if the write fails."

	| objectsWritten |
	<var: #aFile type: 'sqImageFile '>

	objectsWritten := self cCode: 'sqImageFileWrite(&aShort, sizeof(short), 1, aFile)'.
	self success: objectsWritten = 1.
