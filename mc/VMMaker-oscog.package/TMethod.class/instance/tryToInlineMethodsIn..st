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
			[:node|
			(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
				[sendsToInline at: node put: (self inlineFunctionCall: node in: aCodeGen)]]
		unless: "Don't inline the arguments to asserts to keep the asserts readable"
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]].

	sendsToInline isEmpty ifFalse:
		[didSomething := true.
		parseTree := parseTree replaceNodesIn: sendsToInline].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil.
		^didSomething].

	stmtLists := self statementsListsForInliningIn: aCodeGen.
	stmtLists do:
		[:stmtList|
		newStatements := OrderedCollection new: 100.
		stmtList statements do:
			[:stmt|
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