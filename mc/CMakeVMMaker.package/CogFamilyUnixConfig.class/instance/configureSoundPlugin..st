plugin extra rules
configureSoundPlugin: maker 
	"extra rules for SoundPlugin"
	
	maker addPlatformSources: #( 'sqUnixSound').
	maker addExternalLibraries: #( 'asound' )