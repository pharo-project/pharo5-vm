weakness and ephemerality
processWeaklings
	"Go through the remembered set and the weak list, nilling references to
	 any objects that didn't survive the scavenge. Read the class comment
	 for a more in-depth description of the algorithm."
	<inline: false>
	| i rootObj weakCorpse weakObj |
	self assert: self allWeakSurvivorsOnWeakList.
	i := 0.
	[i < rememberedSetSize] whileTrue:
		[rootObj := rememberedSet at: i.
		(manager isWeakNonImm: rootObj)
			ifTrue:
				[self processWeakSurvivor: rootObj.
				 "If no more referents, remove by overwriting with the last element in the set."
				 (manager hasYoungReferents: rootObj)
					ifFalse:
						[manager setIsRememberedOf: rootObj to: false.
						 i + 1 < rememberedSetSize ifTrue:
							[rememberedSet at: i put: (rememberedSet at: rememberedSetSize - 1)].
						 rememberedSetSize := rememberedSetSize - 1]
					ifTrue: [i := i + 1]]
			ifFalse: [i := i + 1]].
	weakList ifNotNil:
		[weakCorpse := self firstCorpse: weakList.
		 [weakCorpse notNil] whileTrue:
			[self assert: (manager isForwarded: weakCorpse).
			 weakObj := manager followForwarded: weakCorpse.
			 self processWeakSurvivor: weakObj.
			 weakCorpse := self nextCorpseOrNil: weakCorpse].
		weakList := nil]