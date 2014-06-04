C code generator
placeInStructure: var
	"See if we should put this array into a structure.
	The variables listed are hardcoded as C in the interpreter thus they don't get resolved via TVariableNode logic.
	Also let's ignore variables that have special definitions that require initialization, and the function def which has problems."

	| check |
	check := variableDeclarations at: var ifAbsent: [''].
	(check includes: $=) ifTrue: [^false].
	(check includes: $() ifTrue: [^false].
	(check includesSubString: 'static') ifTrue: [^false].
	(check includesSubString: 'volatile') ifTrue: [^false].

	^(vmClass mustBeGlobal: var) not