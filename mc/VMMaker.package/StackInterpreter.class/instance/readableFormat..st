image save/restore
readableFormat: imageVersion
	"Anwer true if images of the given format are readable by this interpreter.
	 Allows a virtual machine to accept selected older image formats."

	^imageVersion = self imageFormatVersion "Float words in platform-order"
	   or: [imageVersion = self imageFormatCompatibilityVersion] "Float words in BigEndian order"