plugin code generation
declareCVarsIn: cg

	cg addHeaderFile:'"rePlugin.h"'.

	"Memory Management Error Checking"
	cg var: 'netMemory' 	declareC: 'int netMemory = 0'.
	cg var: 'numAllocs' 	declareC: 'int numAllocs = 0'.
	cg var: 'numFrees' 		declareC: 'int numFrees = 0'.
	cg var: 'lastAlloc'		declareC: 'int lastAlloc = 0'.

	"Support Variables for Access to Receiver Instance Variables"
	cg var: 'patternStrPtr' type: 'const char * '.
	cg var: 'errorStrBuffer'	type: 'const char * '.