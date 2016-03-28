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
	absFun := (#('long long' '__int64' 'int64_t') anySatisfy: [:t| strippedType beginsWith: t]) ifTrue: [#llabs]
		ifFalse: [(strippedType beginsWith: #sqInt) ifTrue: [#SQABS]
		ifFalse: [(strippedType beginsWith: #sqLong) ifTrue: [#SQLABS]
		ifFalse: [(#('float' 'double') anySatisfy: [:t| strippedType beginsWith: t]) ifTrue: [#fabs]
		ifFalse: [#abs]]]].
	
	aStream nextPutAll: absFun.
	aStream nextPut: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $).