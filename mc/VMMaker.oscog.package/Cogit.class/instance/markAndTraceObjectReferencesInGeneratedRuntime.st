jit - api
markAndTraceObjectReferencesInGeneratedRuntime
	"Mark and trace any object references in the generated run-time."
	0 to: runtimeObjectRefIndex - 1 do:
		[:i| | mcpc literal |
		 mcpc := objectReferencesInRuntime at: i.
		 literal := literalsManager fetchLiteralAtAnnotatedAddress: mcpc using: backEnd.
		 objectRepresentation
			markAndTraceLiteral: literal
			in: (self cCoerceSimple: nil to: #'CogMethod *')
			atpc: mcpc asUnsignedInteger]