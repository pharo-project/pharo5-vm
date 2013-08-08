transformations
customizeCase: caseParseTree forVar: varName from: firstIndex to: lastIndex in: codeGen method: aTMethod expandedCases: seen
	"Return a collection of copies of the given parse tree, each of which has the value of the case index substituted for the given variable."

	| newCases dict newCase |
	newCases := OrderedCollection new.
	firstIndex to: lastIndex do:
		[ :caseIndex |
		dict := Dictionary new.
		dict at: varName put: (TConstantNode new setValue: caseIndex).
		newCase := caseParseTree copy bindVariableUsesIn: dict andConstantFoldIf: true in: codeGen.
		self processSharedCodeBlocks: newCase forCase: caseIndex in: codeGen method: aTMethod expandedCases: seen.
		newCases addLast: newCase].
	^newCases