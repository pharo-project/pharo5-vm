private
oopVariable: aString

	(locals includes: aString) ifFalse:
		[locals add: aString.
		self declarationAt: aString put: 'sqInt ', aString].
	^TVariableNode new setName: aString