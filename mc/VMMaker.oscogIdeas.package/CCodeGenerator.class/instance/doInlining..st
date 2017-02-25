inlining
doInlining: inlineFlagOrSymbol
	"Inline the bodies of all methods that are suitable for inlining."
	"Modified slightly for the core VM translator, since the first level of inlining for the interpret loop must be performed in order that the instruction implementations can easily discover their addresses. Remember to inline the bytecode routines as well"

	| removed |
	inlineFlagOrSymbol isSymbol ifTrue:
		[self inlineDispatchesInMethodNamed: #interpret localizingVars: #().	
		 self doBasicInlining: inlineFlagOrSymbol.
		 self pruneUnreachableMethods.
		 ^self].

	inlineFlagOrSymbol ifFalse:
		[self inlineDispatchesInMethodNamed: #interpret localizingVars: #().	
		self pruneUnreachableMethods.
		^self].

	self doBasicInlining: inlineFlagOrSymbol.

	vmClass ifNil: [^self].

	'Inlining bytecodes'
		displayProgressAt: Sensor cursorPoint
		from: 1 to: 2
		during: [:bar |
			self inlineDispatchesInMethodNamed: #interpret
				localizingVars: vmClass namesOfVariablesToLocalize.
			bar value: 1.
			removed := self removeMethodsReferingToGlobals: vmClass namesOfVariablesToLocalize
							except: #interpret.
			bar value: 2].

	"only prune when generating the interpreter itself"
	self pruneUnreachableMethods.

	self reportShouldNotBeRemoved: removed  varList: vmClass namesOfVariablesToLocalize