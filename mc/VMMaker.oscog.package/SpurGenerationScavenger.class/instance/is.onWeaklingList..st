weakness and ephemerality
is: oop onWeaklingList: listHead
	| corpse |
	corpse := self firstCorpse: listHead.
	[corpse notNil] whileTrue:
		[oop = (manager followForwarded: corpse) ifTrue:
			[^true].
		 corpse := self nextCorpseOrNil: corpse].
	^false