instance creation
thisImageFileFormat
	"The image format read from the header of the file from which the current
	image was loaded. This may be different from the current format if the VM
	has modified the image at load time or in the course of running the image."

	"ImageFormat thisImageFileFormat description"

	^self fromFile: Smalltalk imageName
