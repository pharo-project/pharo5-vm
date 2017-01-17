C translation
generateAbs: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| type strippedType absFun |
	type := self typeFor: msgNode receiver in: currentMethod.
	strippedType := (type beginsWith: 'unsigned ')
		ifTrue: [type allButFirst: 'unsigned ' size]
		ifFalse: [(type beginsWith: 'u')
			ifTrue: [type allButFirst: 1]
			ifFalse: [type]].
	absFun :=
		(#(	('long long' llabs) ('__int64' #llabs) ('int64_t' #llabs)
			(sqInt SQABS)
			(sqLong SQLABS)
			(double fabs)
			(float fabsf))
				detect: [:tuple| strippedType beginsWith: tuple first]
				ifNone: [])
			ifNotNil: [:tuple| tuple last]
			ifNil: [#abs].
	
	aStream nextPutAll: absFun.
	aStream nextPut: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)