initialisation
initialize
	"VMMaker initialize"
	DirNames := Dictionary new.
	DirNames at: #coreVMDir put: 'vm';
		at: #platformsDir put: 'platforms';
		at: #pluginsDir put: 'plugins';
		at: #sourceDir put: 'src'