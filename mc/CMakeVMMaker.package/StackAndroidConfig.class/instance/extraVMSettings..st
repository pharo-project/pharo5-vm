source generation
extraVMSettings: maker
	| versionC |
	self generateConfigH.
	
	"add a generated version.c"
	versionC := 'version.c'.

	maker 
		puts: '$(TOP_PATH)/build/',versionC, ':' ;
		puts: ({Character tab}, '$(TOP_PATH)/platforms/',self platformName ,'/config/verstamp ', '$(TOP_PATH)/build/',versionC,' gcc');
		puts: {Character cr};
		puts: ('LOCAL_SRC_FILES += $(TOP_PATH)/build/', versionC);
		puts: {Character cr}.
	.
	