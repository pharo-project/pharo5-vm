utilities
extractTypeFor: aVariable fromDeclaration: aVariableDeclaration
	"Eliminate inessentials from aVariableDeclaration to answer a C type without the variable,
	 or initializations etc"
	| decl |
	decl := aVariableDeclaration.
	(decl beginsWith: 'static') ifTrue:
		[decl := decl allButFirst: 6].
	(decl indexOf: $= ifAbsent: []) ifNotNil:
		[:index| decl := decl copyFrom: 1 to: index - 1].
	decl := decl copyReplaceAll: aVariable with: '' tokenish: [:ch| ch = $_ or: [ch isAlphaNumeric]].
	^self baseTypeForType: decl