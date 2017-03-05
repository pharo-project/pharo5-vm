bytecode generator support
pushForMergeWith: mergeSimStack
	"Answer if values must be pushed from simStack to merge with mergeSimStack, otherwise < 0 (the default)."
	<var: #mergeSimStack type: #'SimStackEntry *'>
	<inline: true>
	simStackPtr to: methodOrBlockNumTemps by: -1 do:
		[:i|
		 (self simStack: mergeSimStack at: i) spilled ~= (self simStack: simStack at: i) spilled ifTrue:
			[^(self simStack: mergeSimStack at: i) spilled]].
	^false