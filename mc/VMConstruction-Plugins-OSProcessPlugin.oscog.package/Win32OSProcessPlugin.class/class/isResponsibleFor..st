translation
isResponsibleFor: platform 
	"Answer true is this is an instance of the class which is responsible for
	representing the named platform. Note: for Windows, the VM reports
	platform name 'Win32', but the platforms directory name is 'win32'.
	VMMaker uses the platforms directory name, so anwer true for either
	name."

	^ platform asLowercase = 'win32'
