inlining
tryToInlineMethodsIn: aCodeGen
	"Expand any (complete) inline methods called by this method. Set the complete bit when all inlining has been done. Return true if something was inlined."

	| stmtLists didSomething newStatements sendsToInline |
	self definedAsMacro ifTrue:
		[complete := true.
		 ^false].
	didSomething := false.
	sendsToInline := Dictionary new: 100.
	parseTree
		nodesDo:
			[ :n |
			(self inlineableFunctionCall: n in: aCodeGen) ifTrue:
				[sendsToInline at: n put: (self inlineFunctionCall: n in: aCodeGen)]]
		unless: "Don't inline the arguments to asserts to keep the asserts readable"
			[:n| n isSend and: [#(cCode:inSmalltalk: assert: asserta:) includes: n selector]].

	sendsToInline isEmpty ifFalse:
		[didSomething := true.
		parseTree := parseTree replaceNodesIn: sendsToInline].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil.
		^didSomething].

	stmtLists := self statementsListsForInlining.
	stmtLists do:
		[ :stmtList | 
		newStatements := OrderedCollection new: 100.
		stmtList statements do:
			[ :stmt |
			(self inlineCodeOrNilForStatement: stmt in: aCodeGen)
				ifNil: [newStatements addLast: stmt]
				ifNotNil: [:inlinedStmts|
					didSomething := true.
					newStatements addAllLast: inlinedStmts]].
		stmtList setStatements: newStatements asArray].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil.
		^didSomething].

	complete ifFalse:
		[self checkForCompleteness: stmtLists in: aCodeGen.
		 complete ifTrue: [ didSomething := true ]].  "marking a method complete is progress"
	^didSomething