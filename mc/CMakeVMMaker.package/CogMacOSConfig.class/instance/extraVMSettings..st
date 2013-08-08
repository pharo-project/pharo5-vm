settings
extraVMSettings: maker
	
	"Cog currently runs only in 32 bit mode" 
	maker set: 'CMAKE_OSX_ARCHITECTURES' to: 'i386'.

	maker set: 'resourceDir' toString: self resourcesDir, '/ProjectBuilder'.
	maker set: 'resources' to: 
		'"${resourceDir}/Squeak VM.r"
		"${resourceDir}/Cog.icns"
		"${resourceDir}/Squeak.icns"
		"${resourceDir}/SqueakChanges.icns"
		"${resourceDir}/SqueakImage.icns"
		"${resourceDir}/SqueakPlugin.icns"
		"${resourceDir}/SqueakScript.icns"
		"${resourceDir}/SqueakGeneric.icns"
		"${resourceDir}/SqueakProject.icns"
		"${resourceDir}/SqueakSources.icns"'
