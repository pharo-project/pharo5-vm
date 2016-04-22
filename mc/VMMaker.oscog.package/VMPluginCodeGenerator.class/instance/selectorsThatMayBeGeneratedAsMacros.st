public
selectorsThatMayBeGeneratedAsMacros
	"Answer a list of selectors that maybe generated as a C macro rather than as an interpreterProxy function call."
	
	^self selectorsThatAreGeneratedAsMacros, #(isIntegerObject: isImmediate:)