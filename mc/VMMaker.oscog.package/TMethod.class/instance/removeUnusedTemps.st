utilities
removeUnusedTemps
	"Remove all of the unused temps in this method. Answer a set of the references."
	"After inlining some variable references are now obsolete, we could fix them there
	 but the code seems a bit complicated, the other choice to to rebuild the locals
	 before extruding. This is done here"
	| refs |
	refs := self allReferencedVariables.
	"reset the locals to be only those still referred to"
	locals := locals select: [:e| refs includes: e].
	^refs