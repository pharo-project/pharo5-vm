translation
declareCVarsIn: cg

	"Additional declarations are done in my subclasses. This permits a meaningful module
	  identification string to be written with the name of the actual subclass being generated."

	cg addHeaderFile: '"FilePlugin.h"'.
	cg addHeaderFile: '"SocketPlugin.h"'.
	"Data type for sessionID, should generate compiler warnings
	 if someone changes the data type elsewhere in the VM."
	cg addConstantForBinding: 'SESSIONIDENTIFIERTYPE' -> #int.
	cg var: 'osprocessSandboxSecurity' declareC: 'int osprocessSandboxSecurity'