image save/restore
writeImageFileIOSimulation
	"Write the image header and heap contents to imageFile for snapshot.
	 c.f. writeImageFileIO"
	<doNotGenerate>
	| headerSize file |
	BytesPerWord = 4 ifFalse: [self error: 'Not rewritten for 64 bits yet'].
	headerSize := 64.

	(file := FileStream fileNamed: self imageName) ifNil:
		[self primitiveFail.
		 ^nil].
	[
		file binary.

		{
			self imageFormatVersion.
			headerSize.
			objectMemory imageSizeToWrite.
			objectMemory baseAddressOfImage.
			objectMemory specialObjectsOop.
			objectMemory lastHash.
			self ioScreenSize.
			self getImageHeaderFlags.
			extraVMMemory ifNil: [0]
		}
			do: [:long | self putLong: long toFile: file].

		{	desiredNumStackPages. self unknownShortOrCodeSizeInKs } do:
			[:short| self putShort: short toFile: file].

		self putLong: desiredEdenBytes toFile: file.

		{	maxExtSemTabSizeSet ifTrue: [self ioGetMaxExtSemTableSize] ifFalse: [0]. 0 } do:
			[:short| self putShort: short toFile: file].

		objectMemory hasSpurMemoryManagerAPI
			ifTrue:
				[| bytesWritten |
				 self putLong: objectMemory firstSegmentBytes toFile: file.
				 self putLong: objectMemory bytesLeftInOldSpace toFile: file.
				 2 timesRepeat: [self putLong: 0 toFile: file "Pad the rest of the header."].

				"Position the file after the header."
				file position: headerSize.
				bytesWritten := objectMemory writeImageSegmentsToFile: file.
				self assert: bytesWritten = objectMemory imageSizeToWrite]
			ifFalse:
				["Pad the rest of the header."
				4 timesRepeat: [self putLong: 0 toFile: file].

				"Position the file after the header."
				file position: headerSize.

				"Write the object memory."
				objectMemory baseAddressOfImage // 4 + 1
					to: objectMemory baseAddressOfImage + objectMemory imageSizeToWrite // 4
					do: [:index |
						self
							putLong: (objectMemory memory at: index)
							toFile: file]].
	
		self success: true
	]
		ensure: [file ifNotNil: [file close]]