drivers
addVMDrivers: maker
"
libICE
ICE is the Inter Client Exchange protocol, part of X11

libSM
session management library for X11

"
	| driver |
	driver := 'vm-display-null' .
	 self 
		addDriver: driver
		sources: {  
			'$(TOP_PATH)/platforms/',self platformName,'/',driver,'/sqUnixDisplayNull.c'.}
		generator: maker
		externalLibs: #().
		
	driver := 'vm-display-android' .
	 self 
		addDriver: driver
		sources: {  
			'$(TOP_PATH)/platforms/',self platformName,'/',driver,'/sqAndroidDisplay.c'.}
		generator: maker
		externalLibs: #().

"	driver := 'vm-sound-ALSA' .
	self 
		addDriver: driver
		sources: {  
			'$(TOP_PATH)/platforms/',self platformName,'/',driver,'/sqUnixSoundALSA.c'.}
		generator: maker
		externalLibs: #()."
	
	driver := 'vm-sound-null' .
	self 
		addDriver: driver
		sources: {  
			'$(TOP_PATH)/platforms/',self platformName,'/',driver,'/sqUnixSoundNull.c'.}
		generator: maker
		externalLibs: #().
	
"
vm-display-null
	vm-display-X11
	vm-sound-ALSA
	vm-sound-null"