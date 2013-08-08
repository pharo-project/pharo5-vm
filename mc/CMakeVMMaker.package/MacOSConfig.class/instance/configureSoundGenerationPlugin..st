plugin extra rules
configureSoundGenerationPlugin: maker 
	"extra rules for SoundPlugin"

	maker doNotGenerate: true. 
	" The sources in platforms/Cross/plugins/SoundGenerationPlugin/sqOldSoundPrims.c 
	are out of date and need to be fixed before it can be built 
	
	
	maker 
		addCrossSources: #('sqOldSoundPrims.c') 

	"
