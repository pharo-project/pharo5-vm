*CogVMMakerPharoCompatibility
doWeFileOut: aClass given: aSet cache: cache
	| aClassAllSuperclasses aClassSoleInstanceAllSuperclasses |
	aClassAllSuperclasses := cache at: aClass ifAbsentPut:[
		aClass allSuperclasses asArray, aClass traitComposition allTraits.
	].
	(aSet includesAnyOf: aClassAllSuperclasses) ifTrue: [^false].
	aClass isMeta ifFalse: [^true].
	(aSet includes: aClass soleInstance) ifTrue: [^false].
	aClassSoleInstanceAllSuperclasses := cache at: aClass soleInstance
		ifAbsentPut: [aClass soleInstance allSuperclasses asArray, aClass soleInstance traitComposition allTraits].
	(aSet includesAnyOf: aClassSoleInstanceAllSuperclasses) ifTrue: [^false].
	^true