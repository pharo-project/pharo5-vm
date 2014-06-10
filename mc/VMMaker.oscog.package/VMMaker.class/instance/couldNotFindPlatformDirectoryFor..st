private - errors
couldNotFindPlatformDirectoryFor: platName
	"This should raise a nice exception to a UI"
	self couldNotFindDirectory: 'for: ', platName, ' specific files; is the platform root path set correctly?'