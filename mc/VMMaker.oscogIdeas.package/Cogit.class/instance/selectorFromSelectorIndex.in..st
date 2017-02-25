in-line cacheing
selectorFromSelectorIndex: selectorIndex in: aCompiledMethod
	<inline: true>
	^selectorIndex < 0
		ifTrue: [(coInterpreter specialSelector: -1 - selectorIndex)]
		ifFalse: [coInterpreter literal: selectorIndex ofMethod: aCompiledMethod]