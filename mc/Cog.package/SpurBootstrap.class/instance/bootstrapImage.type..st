public access
bootstrapImage: imageName type: typeName
	"type can be: 
		- 'squeak' 
		- 'pharo'
		- it might be 'newspeak', if needed (but is not implemented)"
	imageType := typeName.
	self bootstrapImage: imageName
	