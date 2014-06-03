inlining support
computePossibleSideEffectsInto: writtenToVars visited: visitedSelectors in: aCodeGen
	"Add all variables written to by this method and its callees to writtenToVars.
	 Avoid circularity via visitedSelectors"

	(visitedSelectors includes: selector) ifTrue:
		[^self].
	visitedSelectors add: selector.
	writtenToGlobalVarsCache ifNotNil:
		[writtenToVars addAll: writtenToGlobalVarsCache.
		 ^self].
	parseTree nodesDo:
		[ :node |
			(node isAssignment
			 and: [(locals includes: node variable name) not])
				ifTrue:
					[writtenToVars add: node variable name].
			(node isSend
			 and: [node isBuiltinOperator not
			 and: [(node isStructSendIn: aCodeGen) not]]) ifTrue:
				[(aCodeGen methodNamed: node selector) ifNotNil:
					[:method|
					 method
						computePossibleSideEffectsInto: writtenToVars
						visited: visitedSelectors
						in: aCodeGen]]].
	writtenToGlobalVarsCache := writtenToVars copy