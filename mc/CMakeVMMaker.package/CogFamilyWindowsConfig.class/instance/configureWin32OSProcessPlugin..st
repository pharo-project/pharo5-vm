plugin extra rules
configureWin32OSProcessPlugin: maker 
	"extra rules for Win32OSProcessPlugin"

	maker includeDirectories: '${crossDir}/plugins/FilePlugin'.
	maker includeDirectories: '${crossDir}/plugins/SocketPlugin'.
