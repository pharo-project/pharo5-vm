plugin extra rules
configureThreadedIA32FFIPlugin: maker
	"extra rules for ThreadedIA32FFIPlugin"
	
	maker doNotGenerate: true.
	maker addCrossSources: #(
		'sqFFIPlugin.c' 
		'sqFFITestFuncs.c' 
		'sqManualSurface.c' )	