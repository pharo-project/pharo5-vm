source generation
extraVMSettings: maker
	| versionC |
	self generateConfigH.
	
	"add a generated version.c"
	
	versionC := 'version.c'.

	maker 
		puts: '$(buildDir)/',versionC, ':' ;
		puts: ({Character tab}, '$(platformsDir)/android/config/verstamp ', '$(buildDir)/', versionC,' gcc');
		puts: {Character cr};
		puts: ('LOCAL_SRC_FILES += $(buildDir)/', versionC);
		puts: {Character cr}.
	.
	