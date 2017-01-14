testing
needsTrailingSemicolon
	"Answer if, when emitted as a statement (in particular in a TStmtList), the
	 receiver needs a trailing semicolon.  Preprocessor directives and special expansions do not."
	^(self isPreprocessorDirective
	   or: [self isValueExpansion
	   or: [selector == #expandDereferenceInterpreterProxyFunctionTable]]) not