compiler support
initCompilerHooks
	"Initialize hooks for the 'null compiler'"

	self cCode: 'compilerHooks[1]= nullCompilerHook'.
	self cCode: 'compilerHooks[2]= nullCompilerHook'.
	self cCode: 'compilerHooks[3]= nullCompilerHook'.
	self cCode: 'compilerHooks[4]= nullCompilerHook'.
	self cCode: 'compilerHooks[5]= nullCompilerHook'.
	self cCode: 'compilerHooks[6]= nullCompilerHook'.
	self cCode: 'compilerHooks[7]= nullCompilerHook'.
	self cCode: 'compilerHooks[8]= nullCompilerHook'.
	self cCode: 'compilerHooks[9]= nullCompilerHook'.
	self cCode: 'compilerHooks[10]= nullCompilerHook'.
	self cCode: 'compilerHooks[11]= nullCompilerHook'.
	self cCode: 'compilerHooks[12]= nullCompilerHook'.
	self cCode: 'compilerHooks[13]= nullCompilerHook'.
	self cCode: 'compilerHooks[14]= nullCompilerHook'.

	compilerInitialized := false