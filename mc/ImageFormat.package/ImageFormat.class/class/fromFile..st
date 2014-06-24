instance creation
fromFile: imageFile
	"Answer a new instance from a saved image file. The image format number
	is saved in the first 4 or 8 bytes of the file. Word size and byte ordering are
	dependent on the image and platform that saved the file, and must be decoded
	to obtain the image format."

	"ImageFormat fromFile: Smalltalk imageName"

	| f |
	f := (FileStream oldFileNamed: imageFile) ifNil: [FileStream readOnlyFileNamed: imageFile].
	f ifNotNil: [ | imageFormat |
		[f binary.
		imageFormat := self fromStream: f]
			ensure: [f close].
		^imageFormat].
	^self error: 'could not open ', imageFile
