inlining
removeMethodsReferingToGlobals: varList except: methodName
	"Remove any methods (presumably inlined) that still contain references to the given
	 global variables. Answer a Dictionary of the removed methods for later reporting."

	| varListAsStrings removed |
	varListAsStrings := varList collect: [ :sym | sym asString ].
	removed := Dictionary new: methods size / 2.
	methods copy keysAndValuesDo:
		[ :sel :meth| | mVars |
		sel ~= methodName ifTrue:
			[mVars := meth freeVariableReferences asSet.
			 (varListAsStrings anySatisfy: [ :v | mVars includes: v]) ifTrue:
				[removed at: sel put: meth.
				self removeMethodForSelector: sel]]].

	^removed