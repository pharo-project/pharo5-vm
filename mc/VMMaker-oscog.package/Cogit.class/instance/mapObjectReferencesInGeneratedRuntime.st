garbage collection
mapObjectReferencesInGeneratedRuntime
	"Update all references to objects in the generated runtime."
	0 to: runtimeObjectRefIndex - 1 do:
		[:i| | mcpc literal mappedLiteral |
		 mcpc := objectReferencesInRuntime at: i.
		 literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 mappedLiteral := objectMemory remap: literal.
		 mappedLiteral ~= literal ifTrue:
			[backEnd storeLiteral: mappedLiteral beforeFollowingAddress: mcpc.
			 codeModified := true]]