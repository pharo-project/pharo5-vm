inlining
inlineDispatchesInMethodNamed: selector localizingVars: varsList
	"Inline dispatches (case statements) in the method with the given name."

	| m |
	m := self methodNamed: selector.
	m = nil ifFalse: [
		m inlineCaseStatementBranchesIn: self localizingVars: varsList.
		m parseTree nodesDo: [ :n |
			n isCaseStmt ifTrue: [
				n customizeShortCasesForDispatchVar: 'currentBytecode' in: self method: m.
			].
		].
	].
	varsList do: [ :v | | varString |
		varString := v asString.
		self checkDeleteVariable: varString.
		variables remove: varString ifAbsent: [].
		(variableDeclarations includesKey: varString) ifTrue: [
			m declarationAt: v asString put: (variableDeclarations at: varString).
			variableDeclarations removeKey: varString.
		].
	]