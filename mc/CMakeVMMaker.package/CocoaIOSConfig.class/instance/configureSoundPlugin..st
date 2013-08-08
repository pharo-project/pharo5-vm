plugin extra rules
configureSoundPlugin: maker
	super configureSoundPlugin: maker.
	
	maker includeDirectories: '${platformsDir}/Cross/plugins/SoundPlugin ${platformsDir}/iOS/vm/OSX/plugins/SoundPlugin'.
	maker 
		addSources: #('sqSqueakSoundCoreAudio.m' 'sqSqueakSoundCoreAudioAPI.m' ) 
		prefixed: '${platformsDir}/iOS/plugins/SoundPlugin/'.
	maker 
		addSources: #('sqSqueakOSXSoundCoreAudio.m' ) 
		prefixed: '${platformsDir}/iOS/vm/OSX/plugins/SoundPlugin/'