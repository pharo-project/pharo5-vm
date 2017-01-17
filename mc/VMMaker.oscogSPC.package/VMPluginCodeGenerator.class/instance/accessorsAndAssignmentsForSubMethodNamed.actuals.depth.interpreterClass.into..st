spur primitive compilation
accessorsAndAssignmentsForSubMethodNamed: selector actuals: actualParameters depth: depth interpreterClass: interpreterClass into: aTrinaryBlock
	"Evaluate aTrinaryBlock with the root accessor sends, accessor sends and assignments in the sub-method named selector."

	| method map |
	(inProgressSelectors includes: selector) ifTrue:
		[^nil].
	inProgressSelectors add: selector.
	method := self methodNamed: selector.
	"this is unsatisfactory.  a pluggable scheme that asks the relevant plugin the right question would
	 be better but for now the only cross-plugin load is for loadBitBltFrom:warping: and variants."
	(#(loadBitBltFrom: loadWarpBltFrom: loadBitBltFrom:warping:) includes: selector) ifTrue:
		[(method isNil
		  or: [method definingClass ~~ BitBltSimulation]) ifTrue:
			[method := (BitBltSimulation >> selector) methodNode asTranslationMethodOfClass: TMethod]].
	method ifNil:
		[^nil].
	map := Dictionary new.
	method args do: [:var| map at: var put: depth asString, var].
	method locals do: [:var| map at: var put: depth asString, var].
	^self accessorsAndAssignmentsForMethod: (method copy renameVariablesUsing: map)
		actuals: actualParameters
		depth: depth + 1
		interpreterClass: interpreterClass
		into: aTrinaryBlock