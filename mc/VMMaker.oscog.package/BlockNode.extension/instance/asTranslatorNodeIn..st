*VMMaker-C translation
asTranslatorNodeIn: aTMethod
	"make a CCodeGenerator equivalent of me"
	| statementList |
	statementList := OrderedCollection new.
	statements do:
		[:s | | newS |
		 newS := s asTranslatorNodeIn: aTMethod.
		 "inline the statement list returned when a CascadeNode is translated and/or when ifNotNil: is transformed"
		 newS isStmtList
			ifTrue:  [statementList addAll: newS statements]
			ifFalse: [statementList add: newS]].
	^TStmtListNode new
		setArguments: (arguments asArray collect: [:arg | arg key])
		statements: statementList;
		comment: comment