private - errors
couldNotFindDirectory: dirName
	"This should raise a nice exception to a UI"
	^(VMMakerException new messageText: self class name, ' could not find directory ', dirName) signal