inlining
tryToInlineMethodsIn: aCodeGen
	"Expand any (complete) inline methods called by this method. Set the complete bit when all inlining has been done. Return true if something was inlined."

	| stmtLists didSomething newStatements sendsToInline returningNodes |
	self definedAsMacro ifTrue:
		[complete := true.
		 ^false].
	didSomething := false.
	sendsToInline := Dictionary new: 100.
	parseTree
		nodesDo:
			[:node|
			(self transformConditionalAssignment: node in: aCodeGen) ifNotNil:
				[:replacement|
				 sendsToInline at: node put: replacement].
			(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
				[(self inlineFunctionCall: node in: aCodeGen) ifNotNil:
					[:replacement|
					 sendsToInline at: node put: replacement]]]
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

	returningNodes := Set new.
	parseTree nodesDo:
		[:node|
		node isReturn ifTrue:
			[returningNodes add: node expression.
			 node expression isConditionalSend ifTrue:
				[returningNodes addAll: (node expression args collect: [:stmtList| stmtList statements last])]]].
	stmtLists := self statementsListsForInliningIn: aCodeGen.
	stmtLists do:
		[:stmtList|
		newStatements := OrderedCollection new: stmtList statements size.
		stmtList statements do:
			[:stmt|
			(self inlineCodeOrNilForStatement: stmt returningNodes: returningNodes in: aCodeGen)
				ifNil: [newStatements addLast: stmt]
				ifNotNil: [:inlinedStmts|
					didSomething := true.
					newStatements addAllLast: inlinedStmts]].
		stmtList setStatements: newStatements asArray].

	"This is a hack; forgive me. The inlining abiove tends to keep return statements in statement lists.
	 In the case of returning ifs we don't want the returns in case the returning if is generated as an expression."
	returningNodes do:
		[:returningNode|
		 (returningNode isConditionalSend
		  and: [returningNode args anySatisfy: [:alternativeNode| alternativeNode endsWithReturn]]) ifTrue:
			[returningNode args withIndexDo:
				[:alternativeNode :index|
				 alternativeNode endsWithReturn ifTrue:
					[returningNode args at: index put: alternativeNode copyWithoutReturn]]]].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil.
		^didSomething].

	complete ifFalse:
		[self checkForCompleteness: stmtLists in: aCodeGen.
		 complete ifTrue: [ didSomething := true ]].  "marking a method complete is progress"
	^didSomething