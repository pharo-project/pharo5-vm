plugin extra rules
configureThreadedFFIPlugin: maker
	"extra rules for ThreadedFFIPlugin"
	
	maker addCrossSources: #(
		'sqFFIPlugin.c' 
		'sqFFITestFuncs.c' 
		'sqManualSurface.c' )