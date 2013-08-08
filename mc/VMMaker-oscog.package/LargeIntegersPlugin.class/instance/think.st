debugging
think
	"Flag for marking methods for later thinking."
	self debugCode: [self msg: '#think should not be called'].
	^nil