C translation
generateWhileForeverBreakIf: breakBoolean loop: msgNode on: aStream indent: level
	"Generate either of
		while(1) {stmtListA; if(cond) break; stmtListB}
		while(1) {stmtListA; if(!(cond)) break; stmtListB}."

	| testStmt receiverWithoutTest |
	aStream peekLast ~~ Character tab ifTrue:
		[aStream tab: level - 1].
	aStream nextPutAll: 'while (1) {'; cr.
	testStmt := msgNode receiver statements last.
	receiverWithoutTest := TStmtListNode new setStatements: msgNode receiver statements allButLast.
	receiverWithoutTest emitCCodeOn: aStream level: level + 1 generator: self.
	aStream tab: level + 1; nextPutAll: 'if ('.
	breakBoolean ifFalse: [aStream nextPut: $!; nextPut: $(].
	testStmt emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
	breakBoolean ifFalse: [aStream nextPut: $)].
	aStream nextPutAll: ') break;'; cr.
	msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
	aStream tab: level; nextPut: $}