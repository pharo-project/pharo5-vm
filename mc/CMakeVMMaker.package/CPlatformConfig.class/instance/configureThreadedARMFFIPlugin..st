plugin extra rules
configureThreadedARMFFIPlugin: maker
	"extra rules for ThreadedARMFFIPlugin"
	
	maker addCrossSources: #(
		'sqFFIPlugin.c' 'sqFFITestFuncs.c' 'sqManualSurface.c'
	).