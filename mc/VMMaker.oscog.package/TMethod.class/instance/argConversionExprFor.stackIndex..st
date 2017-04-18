primitive compilation
argConversionExprFor: varName stackIndex: stackIndex 
	"Return the parse tree for an expression that fetches and converts the 
	primitive argument at the given stack offset."
	| exprList decl type stmtList |
	exprList := OrderedCollection new.
	((decl := declarations at: varName ifAbsent: []) notNil
	 and: ['int' ~= (type := (decl copyReplaceAll: varName with: '') withBlanksTrimmed)])
		ifTrue:
			[(decl includes: $*) ifTrue: "array"
				[(decl includesSubString: 'char')
					ifTrue:
						[| expr |
						expr := '(interpreterProxy isBytes: (interpreterProxy stackValue: (stackIndex))) ifFalse: [^interpreterProxy primitiveFail]'.
						expr := expr copyReplaceAll: 'interpreterProxy' with: self vmNameString.
						expr := expr copyReplaceAll: 'stackIndex' with: stackIndex printString.
						exprList addLast: expr].
					exprList addLast: varName , ' := ', self vmNameString, ' arrayValueOf: (', self vmNameString, ' stackValue: (' , stackIndex printString , '))'.
					exprList addLast: varName , ' := ' , varName , ' - 1'] "so that varName[1] is the zero'th element"
				ifFalse: "must be a double"
					[type ~= 'double' ifTrue:
						[self error: 'unsupported type declaration in a translated primitive method'].
					 exprList addLast: varName , ' := ', self vmNameString, ' stackFloatValue: ' , stackIndex printString]]
			ifFalse: "undeclared variables are taken to be integer"
				[exprList addLast: varName , ' := ', self vmNameString, ' stackIntegerValue: ' , stackIndex printString].
	stmtList := OrderedCollection new.
	exprList do: [:e | stmtList addAll: (self statementsFor: e varName: varName)].
	^ stmtList