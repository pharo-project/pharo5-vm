C translation
generateShiftRight: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| type |
	"If the variable is a 64-bit type then don't cast it to usqInt (typically a 32-bit type)"
	(self is64BitIntegralVariable: msgNode receiver typeInto: [:t| type := t])
		ifTrue:
			["If not unsigned cast it to unsigned."
			 type first ~= $u ifTrue:
				[aStream nextPutAll: '((unsigned '; nextPutAll: type; nextPut: $)].
			 self emitCExpression: msgNode receiver on: aStream indent: level.
			 type first ~= $u ifTrue:
				[aStream nextPut: $)]]
		ifFalse:
			[aStream nextPutAll: '((usqInt) '.
			 self emitCExpression: msgNode receiver on: aStream indent: level.
			 aStream nextPut: $)].
	aStream nextPutAll: ' >> '.
	self emitCExpression: msgNode args first on: aStream indent: level