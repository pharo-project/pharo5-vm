sound library
assimilateSoundsFrom: aDictionary
 	"assimilate sounds with new keys from the given dictionary"
 
 	aDictionary associationsDo:
 		[:assoc | (SoundLibrary includesKey: assoc key) ifFalse:
 			[SoundLibrary add: assoc]]