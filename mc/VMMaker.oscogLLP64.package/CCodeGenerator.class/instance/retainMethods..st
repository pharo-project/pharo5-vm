inlining
retainMethods: aListOfSelectorsToKeep
	"add aListOfSelectorsToKeep to requiredSelectors so that they will not be pruned"
	requiredSelectors ifNil:[requiredSelectors := Set new:100].
	requiredSelectors addAll: aListOfSelectorsToKeep.
	^aListOfSelectorsToKeep