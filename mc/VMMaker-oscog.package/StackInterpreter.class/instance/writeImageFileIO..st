image save/restore
writeImageFileIO: imageBytes

	| headerStart headerSize f bytesWritten sCWIfn okToWrite memStart |
	<var: #f type: 'sqImageFile'>
	<var: #headerStart type: 'squeakFileOffsetType '>
	<var: #sCWIfn type: 'void *'>

	"If the security plugin can be loaded, use it to check for write permission.
	If not, assume it's ok"
	sCWIfn := self ioLoadFunction: 'secCanWriteImage' From: 'SecurityPlugin'.
	sCWIfn ~= 0 ifTrue:
		[okToWrite := self cCode: '((sqInt (*)(void))sCWIfn)()'.
		 okToWrite ifFalse:[^self primitiveFail]].
	
	"local constants"
	headerStart := 0.  
	headerSize := 64.  "header size in bytes; do not change!"

	f := self cCode: 'sqImageFileOpen(imageName, "wb")'.
	f = nil ifTrue: "could not open the image file for writing"
		[^self primitiveFail].

	headerStart := self cCode: 'sqImageFileStartLocation(f,imageName,headerSize+imageBytes)'.
	self cCode: '/* Note: on Unix systems one could put an exec command here, padded to 512 bytes */'.
	"position file to start of header"
	self sqImageFile: f Seek: headerStart.

	self putLong: self imageFormatVersion toFile: f.
	self putLong: headerSize toFile: f.
	self putLong: imageBytes toFile: f.
	self putLong: objectMemory startOfMemory toFile: f.
	self putLong: objectMemory specialObjectsOop toFile: f.
	self putLong: objectMemory newObjectHash toFile: f.
	self putLong: self ioScreenSize toFile: f.
	self putLong: self getImageHeaderFlags toFile: f.
	self putLong: extraVMMemory toFile: f.
	self putShort: desiredNumStackPages toFile: f.
	self putShort: self unknownShortOrCodeSizeInKs toFile: f.
	self putLong: desiredEdenBytes toFile: f.
	self putShort: (maxExtSemTabSizeSet ifTrue: [self ioGetMaxExtSemTableSize] ifFalse: [0]) toFile: f.
	self putShort: 0 toFile: f.
	1 to: 4 do: [:i | self putLong: 0 toFile: f].  "fill remaining header words with zeros"
	self successful ifFalse: [
		"file write or seek failure"
		self cCode: 'sqImageFileClose(f)'.
		^ nil].

	"position file after the header"
	self sqImageFile: f Seek: headerStart + headerSize.

	"write the image data"
	memStart := objectMemory startOfMemory.
	bytesWritten := self cCode: 'sqImageFileWrite(pointerForOop(memStart), sizeof(unsigned char), imageBytes, f)'.
	self success: bytesWritten = imageBytes.
	self touch: memStart.
	self cCode: 'sqImageFileClose(f)'
