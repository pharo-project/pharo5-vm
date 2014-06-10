debug support
printWeaklingList: listHead
	"Print the objects on either the weakList or the ephemeronList."
	| corpse |
	corpse := self firstCorpse: listHead.
	corpse ifNil:
		[coInterpreter print: 'empty'; cr.
		 ^self].
	[corpse notNil] whileTrue:
		[coInterpreter printHexnp: corpse; print: ' -> '; shortPrintOop: (manager followForwarded: corpse).
		 corpse := self nextCorpseOrNil: corpse]