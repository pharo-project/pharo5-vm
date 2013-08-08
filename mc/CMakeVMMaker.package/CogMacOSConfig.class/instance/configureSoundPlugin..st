plugin extra rules
configureSoundPlugin: maker 
	"extra rules for SoundPlugin"

	super configureSoundPlugin: maker.  
	maker includeDirectories: '${platformsDir}/unix/vm/'.
	maker addPlatformSources:
		#( 
			"This is commented because such file is not commited in the cog blessed commit hash f3fe94c828f66cd0e7c37cfa3434e384ff65915e. For more details see http://forum.world.st/Problem-generating-Mac-VM-td3438466.html "
			"'sqMacAudioDeviceList.c'"
			'sqMacUnixInterfaceSound.c' 
			'sqUnixSoundMacOSXJMM.c'
		)


