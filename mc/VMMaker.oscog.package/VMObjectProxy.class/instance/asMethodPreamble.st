as yet unclassified
asMethodPreamble
	| realSelector |
	self flag: #fixMe. "HACK (just to see if it passes :P)"
	realSelector := (coInterpreter shortPrint: oop) allButFirst asSymbol.
	^ realSelector asMethodPreamble