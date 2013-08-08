plugin extra rules
configureUnixOSProcessPlugin: maker
	"extra rules for UnixOSProcessPlugin"

	maker includeDirectories: '${crossDir}/plugins/FilePlugin'.
	
	
	
	"THIS IS UGLY AND LAME!!! "
	maker set: #linkFlags toString: '-undefined dynamic_lookup'