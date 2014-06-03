C translation
generateWhile: boolean loop: msgNode on: aStream indent: level
	"Generate while(cond) {stmtList} or while(!(cond)) {stmtList}."

	aStream nextPutAll: 'while ('.
	boolean ifFalse: [aStream nextPutAll: '!('].
	self emitCTestBlock: msgNode receiver on: aStream indent: level.
	boolean ifFalse: [aStream nextPut: $)].
	aStream nextPutAll: ') {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitCCodeOn: aStream level: level + 1 generator: self].
	aStream tab: level.
	aStream nextPut: $}