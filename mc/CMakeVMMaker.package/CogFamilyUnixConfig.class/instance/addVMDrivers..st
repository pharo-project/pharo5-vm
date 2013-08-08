utils
addVMDrivers: maker
"
libICE
ICE is the Inter Client Exchange protocol, part of X11

libSM
session management library for X11

"
	 self 
		addDriver: 'vm-display-null' 
		sources: #( 
			'${targetPlatform}/vm-display-null/sqUnixDisplayNull' )
		generator: maker
		externalLibs: #();
		
		
		addDriver: 'vm-display-X11' 
		sources: #( 
			'${targetPlatform}/vm-display-X11/sqUnixX11'
			'${targetPlatform}/vm-display-X11/sqUnixMozilla' )
		generator: maker
		
		"-lSM -lICE -ldl -lGL -lpthread -lm -lnsl -lX11'"
		externalLibs: #( SM ICE GL X11 nsl dl);
		

		addDriver: 'vm-sound-ALSA' 
		sources: #( 
			'${targetPlatform}/vm-sound-ALSA/sqUnixSoundALSA' )
		generator: maker
		externalLibs: #();

		addDriver: 'vm-sound-null' 
		sources: #( 
			'${targetPlatform}/vm-sound-null/sqUnixSoundNull' )
		generator: maker
		externalLibs: #().
	
"
vm-display-null
	vm-display-X11
	vm-sound-ALSA
	vm-sound-null"