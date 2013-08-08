C translation
generateDoWhileTrue: msgNode on: aStream indent: level
	"Generate do {stmtList} while(cond)"

	| testStmt receiverWithoutTest |
	testStmt := msgNode receiver statements last.
	receiverWithoutTest := TStmtListNode new setStatements: msgNode receiver statements allButLast.
	aStream nextPutAll: 'do {'; cr.
	receiverWithoutTest emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '} while('.
	testStmt emitCCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ')'.