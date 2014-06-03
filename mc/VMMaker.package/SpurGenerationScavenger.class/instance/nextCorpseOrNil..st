weakness and ephemerality
nextCorpseOrNil: corpse
	"corpse is the corpse of a weak array that has been added to the weakList.
	 Answer the next object on the list, or nil if none."
	| listOffset |
	self assert: (manager isYoung: corpse).
	listOffset := self nextCorpseOffset: corpse.
	^listOffset ~= 0 ifTrue:
		[self corpseForCorpseOffset: listOffset]