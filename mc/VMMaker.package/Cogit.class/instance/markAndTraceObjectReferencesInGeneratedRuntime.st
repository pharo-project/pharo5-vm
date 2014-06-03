jit - api
markAndTraceObjectReferencesInGeneratedRuntime
	"Mark and trace any object references in the generated run-time."
	0 to: runtimeObjectRefIndex - 1 do:
		[:i| | mcpc literal |
		 mcpc := objectReferencesInRuntime at: i.
		 literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteral: literal]