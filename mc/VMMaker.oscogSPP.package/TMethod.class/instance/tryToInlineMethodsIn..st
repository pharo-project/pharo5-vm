inlining
tryToInlineMethodsIn: aCodeGen
	"Expand any (complete) inline methods sent by this method.
	 Set the complete flag when all inlining has been done.
	 Answer if something was inlined."

	| didSomething statementLists |
	"complete ifTrue:
		[^false]."

	self definedAsMacro ifTrue:
		[complete ifTrue:
			[^false].
		 ^complete := true].

	didSomething := self tryToInlineMethodStatementsIn: aCodeGen statementListsInto: [:stmtLists| statementLists := stmtLists].
	didSomething := (self tryToInlineMethodExpressionsIn: aCodeGen) or: [didSomething].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil].

	complete ifFalse:
		[self checkForCompletenessIn: aCodeGen.
		 complete ifTrue: [didSomething := true]].  "marking a method complete is progress"
	^didSomething