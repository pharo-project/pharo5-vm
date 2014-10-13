utils
addVMDrivers: maker
"
libICE
ICE is the Inter Client Exchange protocol, part of X11

libSM
session management library for X11

"
	 self 

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