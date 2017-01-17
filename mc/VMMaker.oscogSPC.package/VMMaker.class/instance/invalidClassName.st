private - errors
invalidClassName
	"This should raise a nice exception to a UI"
	(VMMakerException new messageText: self class name, ' invalid interpreter class name: ', interpreterClassName) signal