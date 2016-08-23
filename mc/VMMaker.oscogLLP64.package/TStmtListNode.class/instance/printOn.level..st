printing
printOn: aStream level: level

	statements size > 1 ifTrue: [ aStream crtab: level + 1 ].
	aStream nextPut: $[.
	(arguments notNil and: [arguments notEmpty]) ifTrue:
		[arguments do: [ :arg | aStream nextPutAll: ' :'; nextPutAll: arg].
		 aStream nextPutAll: ' | '].
	self printStatementsOn: aStream level: level.
	aStream nextPut: $]