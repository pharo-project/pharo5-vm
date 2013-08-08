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
		[ :oldName :decl|
		(aDictionary at: oldName ifAbsent: nil)
			ifNotNil: [:newName|
					newDecls
						at: newName
						put: ((decl endsWith: oldName)
								ifTrue: [(decl allButLast: oldName size), newName]
								ifFalse:
									[Transcript cr; show: 'suspicious renaming ', oldName, ' -> ', newName, ' ', decl, ' in ', selector.
									 decl])]
			ifNil: [ newDecls at: oldName put: decl ]].
	self newDeclarations: newDecls.

	"map variable names in parse tree"
	parseTree nodesDo: [ :node |
		(node isVariable
		and: [aDictionary includesKey: node name]) ifTrue:
			[node setName: (aDictionary at: node name)].
		(node isStmtList and: [node args size > 0]) ifTrue:
			[node setArguments: (node args collect: [ :arg | aDictionary at: arg ifAbsent: [ arg ]])]]