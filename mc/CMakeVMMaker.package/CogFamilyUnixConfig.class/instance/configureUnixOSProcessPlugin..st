plugin extra rules
configureUnixOSProcessPlugin: maker 
	"extra rules for UnixOSProcessPlugin"

	maker includeDirectories: '${crossDir}/plugins/FilePlugin'.
	maker includeDirectories: '${crossDir}/plugins/SocketPlugin'.
	
	maker addDefinitions: '-DSQAIO_H=\"sqaio.h\"'
