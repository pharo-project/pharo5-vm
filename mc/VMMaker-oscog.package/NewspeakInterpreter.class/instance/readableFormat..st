image save/restore
readableFormat: imageVersion
	"Anwer true if images of the given format are readable by this interpreter. Allows a virtual machine to accept selected older image formats.  In our case we can select a newer (closure) image format as well as the existing format."

	^ imageVersion = self imageFormatVersion
	or: [imageVersion = self imageFormatForwardCompatibilityVersion]
"
	Example of multiple formats:
	^ (imageVersion = self imageFormatVersion) or: [imageVersion = 6504]
"