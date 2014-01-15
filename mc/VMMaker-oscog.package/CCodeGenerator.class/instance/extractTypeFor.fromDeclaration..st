utilities
extractTypeFor: aVariable fromDeclaration: aVariableDeclaration
	"Eliminate inessentials from aVariableDeclaration to answer a C type without the variable,
	 or initializations etc"
	| decl fpIndex |
	decl := aVariableDeclaration.
	(decl beginsWith: 'static') ifTrue:
		[decl := decl allButFirst: 6].
	(decl indexOf: $= ifAbsent: []) ifNotNil:
		[:index| decl := decl copyFrom: 1 to: index - 1].
	decl := decl copyReplaceAll: aVariable with: '' tokenish: [:ch| ch = $_ or: [ch isAlphaNumeric]].
	(fpIndex := decl indexOfSubCollection: '(*') > 0 ifTrue:
		[decl := decl copyReplaceFrom: (decl indexOf: $( startingAt: fpIndex + 1)
					to: (decl indexOf: $) startingAt: fpIndex + 1)
					with: ''].
	^decl trimBoth