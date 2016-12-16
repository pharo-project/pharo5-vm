inlining
tryToInlineMethodsIn: aCodeGen
	"Expand any (complete) inline methods sent by this method.
	 Set the complete flag when all inlining has been done.
	 Answer if something was inlined."

	| didSomething statementLists |
	self definedAsMacro ifTrue:
		[complete := true.
		 ^false].
	didSomething := self tryToInlineMethodStatementsIn: aCodeGen statementListsInto: [:stmtLists| statementLists := stmtLists].
	didSomething := (self tryToInlineMethodExpressionsIn: aCodeGen) or: [didSomething].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil.
		^didSomething].

	complete ifFalse:
		[self checkForCompleteness: statementLists in: aCodeGen.
		 complete ifTrue: [didSomething := true]].  "marking a method complete is progress"
	^didSomething