C translation
generateWhileTrueLoop: msgNode on: aStream indent: level
	"Generate while(cond) {stmtList}."

	aStream nextPutAll: 'while ('.
	self emitCTestBlock: msgNode receiver on: aStream indent: level.
	aStream nextPutAll: ') {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitCCodeOn: aStream level: level + 1 generator: self].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.