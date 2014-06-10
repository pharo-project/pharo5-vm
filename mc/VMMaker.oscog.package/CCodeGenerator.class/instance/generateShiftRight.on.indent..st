C translation
generateShiftRight: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| decl |
	"If the variable is a 64-bit type then don't cast it to usqInt (typically a 32-bit type)"
	(msgNode receiver isVariable
	 and: [(decl := self typeOfVariable: msgNode receiver name) notNil
	 and: [#('usqLong' 'sqLong' 'unsigned long long' 'long long' 'unsigned __int64' '__int64')
			anySatisfy: [:type| decl beginsWith: type]]])
		ifTrue:
			["If not unsigned cast it to unsigned."
			 (decl first = $u) ifFalse:
				[aStream
					nextPutAll: '((unsigned ';
					nextPutAll: ((decl endsWith: msgNode receiver name)
									ifTrue: [decl allButLast: msgNode receiver name size]
									ifFalse: [decl]);
					nextPut: $)].
			 self emitCExpression: msgNode receiver on: aStream.
			 (decl first = $u) ifFalse:
				[aStream nextPut: $)]]
		ifFalse:
			[aStream nextPutAll: '((usqInt) '.
			 self emitCExpression: msgNode receiver on: aStream.
			 aStream nextPut: $)].
	aStream nextPutAll: ' >> '.
	self emitCExpression: msgNode args first on: aStream