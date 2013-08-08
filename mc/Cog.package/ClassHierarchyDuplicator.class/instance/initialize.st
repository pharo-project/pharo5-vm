initialize-release
initialize
	| globalNames |
	prefix := 'XXX'.
	classes := Set new.
	((SystemOrganization categories reject: [:c| c beginsWith: prefix]) select:
		[:c| ('*Compiler*' match: c) and: [#'Compiler-Morphing Bytecode Set' ~= c]]) do:
			[:cat|
			(SystemOrganization listAtCategoryNamed: cat) do:
				[:cn|
				classes add: (Smalltalk at: cn)]].
	globalNames := classes collect: [:ea| ea name asString].
	classes do: [:c| c classPool keys do: [:sym| globalNames add: sym asString]].
	xlator := [:s| (globalNames includes: s) ifTrue: [prefix, s] ifFalse: [s]]

	"self new edit"