image save/restore
writeImageFileIO
	"Write the image header and heap contents to imageFile for snapshot."
	| imageName headerStart headerSize f imageBytes bytesWritten sCWIfn okToWrite |
	<var: #f type: #sqImageFile>
	<var: #headerStart type: #squeakFileOffsetType>
	<var: #sCWIfn type: #'void *'>
	<var: #imageName declareC: 'extern char imageName[]'>

	self cCode: [] inSmalltalk: [imageName := 'sooth compiler'. ^self writeImageFileIOSimulation].

	"If the security plugin can be loaded, use it to check for write permission.
	 If not, assume it's ok"
	sCWIfn := self ioLoadFunction: 'secCanWriteImage' From: 'SecurityPlugin'.
	sCWIfn ~= 0 ifTrue:
		[okToWrite := self cCode: '((sqInt (*)(void))sCWIfn)()'.
		 okToWrite ifFalse:[^self primitiveFail]].
	
	"local constants"
	headerStart := 0.  
	headerSize := 64.  "header size in bytes; do not change!"

	f := self sqImageFile: imageName Open: 'wb'.
	f = nil ifTrue: "could not open the image file for writing"
		[^self primitiveFail].

	imageBytes := objectMemory imageSizeToWrite.
	headerStart := self sqImage: f File: imageName StartLocation: headerSize + imageBytes.
	self cCode: '/* Note: on Unix systems one could put an exec command here, padded to 512 bytes */'.
	"position file to start of header"
	self sqImageFile: f Seek: headerStart.

	self putLong: self imageFormatVersion toFile: f.
	self putLong: headerSize toFile: f.
	self putLong: imageBytes toFile: f.
	self putLong: objectMemory baseAddressOfImage toFile: f.
	self putLong: objectMemory specialObjectsOop toFile: f.
	self putLong: objectMemory newObjectHash toFile: f.
	self putLong: self ioScreenSize toFile: f.
	self putLong: self getImageHeaderFlags toFile: f.
	self putLong: extraVMMemory toFile: f.
	self putShort: desiredNumStackPages toFile: f.
	self putShort: self unknownShortOrCodeSizeInKs toFile: f.
	self putLong: desiredEdenBytes toFile: f.
	self putShort: (maxExtSemTabSizeSet ifTrue: [self ioGetMaxExtSemTableSize] ifFalse: [0]) toFile: f.
	self putShort: the2ndUnknownShort toFile: f.
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[self putLong: objectMemory firstSegmentBytes toFile: f.
			 self putLong: objectMemory bytesLeftInOldSpace toFile: f.
			 1 to: 2 do: [:i| self putLong: 0 toFile: f]	"Pad the rest of the header."]
		ifFalse:
			[1 to: 4 do: [:i| self putLong: 0 toFile: f]].  "fill remaining header words with zeros"
	"position file after the header"
	self sqImageFile: f Seek: headerStart + headerSize.

	self successful ifFalse: "file write or seek failure"
		[self sqImageFileClose: f.
		 ^nil].

	"write the image data"
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[bytesWritten := objectMemory writeImageSegmentsToFile: f]
		ifFalse:
			[bytesWritten := self sq: (self pointerForOop: objectMemory baseAddressOfImage)
								Image: (self sizeof: #char)
								File: imageBytes
								Write: f].
	self success: bytesWritten = imageBytes.
	self sqImageFileClose: f