private - errors
couldNotOpenFile: fileName
	"This should raise a nice exception to a UI"
	(VMMakerException new messageText: self class name, ' could not open file: ', fileName) signal