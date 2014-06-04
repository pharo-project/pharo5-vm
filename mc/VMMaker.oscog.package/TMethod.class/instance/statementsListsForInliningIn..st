inlining
statementsListsForInliningIn: aCodeGen
	"Answer a collection of statement list nodes that are candidates for inlining.
	 Currently, we cannot inline into the argument blocks of and: and or: messages.
	 We do not want to inline code strings within cCode:inSmalltalk: blocks (those with a
	 proper block for the cCode: argument are inlined in MessageNode>>asTranslatorNodeIn:).
	 We do not want to inline code within assert: sends (because we want the assert to read nicely)."

	| stmtLists |
	stmtLists := OrderedCollection new: 10.
	parseTree
		nodesDo:
			[:node|
			node isStmtList ifTrue: [stmtLists add: node]]
		unless:
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]].
	parseTree nodesDo:
		[:node|
		node isSend ifTrue:
			[node selector = #cCode:inSmalltalk: ifTrue:
				[node nodesDo:
					[:ccisNode| stmtLists remove: ccisNode ifAbsent: []]].
			 node selector = #cppIf:ifTrue:ifFalse: ifTrue:
				[node args first nodesDo:
					[:inCondNode| stmtLists remove: inCondNode ifAbsent: []]].
			((node selector = #and:) or: [node selector = #or:]) ifTrue:
				"Note: the PP 2.3 compiler produces two arg nodes for these selectors"
				[stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args last ifAbsent: []].
			(#(	#ifTrue: #ifFalse: #ifTrue:ifFalse: #ifFalse:ifTrue:
				#ifNil: #ifNotNil: #ifNil:ifNotNil: #ifNotNil:ifNil: ) includes: node selector) ifTrue:
				[stmtLists remove: node receiver ifAbsent: []].
			(#(whileTrue whileTrue: whilefalse whileFalse:) includes: node selector) ifTrue:
				"Allow inlining if it is a [...] whileTrue/whileFalse.
				This is identified by having more than one statement in the 
				receiver block in which case the C code wouldn't work anyways"
				[node receiver statements size = 1 ifTrue:
					[stmtLists remove: node receiver ifAbsent: []]].
			(node selector = #to:do:) ifTrue:
				[stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: []].
			(node selector = #to:by:do:) ifTrue:
				[stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args second ifAbsent: []]].
		node isCaseStmt ifTrue: "don't inline cases"
			[node cases do: [:case| stmtLists remove: case ifAbsent: []]]].
	^stmtLists