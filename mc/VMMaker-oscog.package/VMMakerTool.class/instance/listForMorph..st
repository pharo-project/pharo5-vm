list access
listForMorph: aMorph
	"work out which list is the one associated with this morph"
	allPluginsList = aMorph ifTrue:[^allPluginsList getListSelector].
	internalPluginsList = aMorph ifTrue:[^internalPluginsList getListSelector].
	externalPluginsList =aMorph ifTrue:[^externalPluginsList getListSelector].
	^nil