bytecode generator support
directionForMergeWith: mergeSimStack
	"Answer > 0 if values must be pushed from simStack to merge with mergeSimStack, otherwise < 0 (the default)."
	<var: #mergeSimStack type: #'SimStackEntry *'>
	<inline: true>
	simStackPtr to: methodOrBlockNumArgs by: -1 do:
		[:i|
		 (self simStack: mergeSimStack at: i) spilled ifTrue:
			[(self simStack: simStack at: i) spilled ifFalse:
				[^1]]].
	^-1