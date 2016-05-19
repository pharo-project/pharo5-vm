public access
bootstrapImage: imageName type: typeNameOrArrayOfTypeNames
	"type can be:
		- 'squeak'
		- {'old squeak' 'squeak' }
		- { 'cuis' 'squeak' }
		- 'pharo'
		- it might be 'newspeak', if needed (but is not implemented)"
	imageTypes := typeNameOrArrayOfTypeNames isArray
						ifTrue: [typeNameOrArrayOfTypeNames]
						ifFalse: [{typeNameOrArrayOfTypeNames}].
	self bootstrapImage: imageName
	