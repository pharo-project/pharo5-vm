plugin extra rules
configureReentrantIA32FFIPlugin: maker
	"extra rules for ReentrantIA32FFIPlugin"
	
	maker addCrossSources: #(
		'sqFFIPlugin.c' 'sqFFITestFuncs.c' 'sqManualSurface.c'
	).

