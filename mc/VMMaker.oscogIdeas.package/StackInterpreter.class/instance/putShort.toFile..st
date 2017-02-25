image save/restore
putShort: aShort toFile: aFile
	"Append the 16-bit aShort to aFile in this platform's 'natural' byte order.
	 (Bytes will be swapped, if necessary, when the image is read on a
	 different platform.) Set successFlag to false if the write fails."

	<var: #aShort type: #short>
	<var: #aFile type: #sqImageFile>
	<inline: false>
	| objectsWritten |
	objectsWritten := self
						cCode: [self sq: (self addressOf: aShort) Image: (self sizeof: #short) File: 1 Write: aFile]
						inSmalltalk:
							[aFile
								nextPut: (aShort bitAnd: 16rFF);
								nextPut: (aShort >> 8 bitAnd: 16rFF).
							 1].
	self success: objectsWritten = 1