inlining support
renameVariablesUsing: aDictionary
	"Rename all variables according to old->new mappings of the given dictionary."

	| newDecls |
	"map args and locals"
	args := args collect: [ :arg | aDictionary at: arg ifAbsent: [ arg ]].
	locals := locals collect: [ :v | aDictionary at: v ifAbsent: [ v ]].

	"map declarations"
	newDecls := declarations species new.
	declarations keysAndValuesDo:
		[:oldName :decl|
		(aDictionary at: oldName ifAbsent: nil)
			ifNotNil:
				[:newName| | index |
				index := decl indexOfWord: oldName.
				 newDecls
					at: newName
					put: (index ~= 0
							ifTrue: [decl copyReplaceFrom: index to: index + oldName size - 1 with: newName]
							ifFalse: [decl])]
			ifNil: [newDecls at: oldName put: decl]].
	self newDeclarations: newDecls.

	"map variable names in parse tree"
	parseTree nodesDo:
		[ :node |
		(node isVariable
		and: [aDictionary includesKey: node name]) ifTrue:
			[node setName: (aDictionary at: node name)].
		(node isStmtList and: [node args size > 0]) ifTrue:
			[node setArguments: (node args collect: [ :arg | aDictionary at: arg ifAbsent: [ arg ]])]]