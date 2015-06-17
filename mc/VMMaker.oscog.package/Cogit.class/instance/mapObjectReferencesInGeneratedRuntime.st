garbage collection
mapObjectReferencesInGeneratedRuntime
	"Update all references to objects in the generated runtime."
	0 to: runtimeObjectRefIndex - 1 do:
		[:i| | mcpc literal mappedLiteral |
		 mcpc := objectReferencesInRuntime at: i.
		 literal := literalsManager fetchLiteralAtAnnotatedAddress: mcpc using: backEnd.
		 mappedLiteral := objectRepresentation remapObject: literal.
		 mappedLiteral ~= literal ifTrue:
			[literalsManager storeLiteral: mappedLiteral atAnnotatedAddress: mcpc using: backEnd.
			 codeModified := true]]