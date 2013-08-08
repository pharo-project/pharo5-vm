inlining
isFunctional
	"Answer true if the receiver is a functional method. That is, if it
	 consists of a single return statement of an expression that contains
	 no other returns.

	 Answer false for methods with return types other than #sqInt to work
	 around bugs in the inliner."

	(parseTree statements size = 1 and:
	 [parseTree statements last isReturn]) ifFalse: [ ^false ].
	parseTree statements last expression nodesDo: [ :n | n isReturn ifTrue: [ ^false ]].
	returnType = #sqInt ifFalse:[^false].
	^true