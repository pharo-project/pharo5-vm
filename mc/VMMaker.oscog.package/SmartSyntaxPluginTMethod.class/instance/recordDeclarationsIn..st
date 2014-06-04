transforming
recordDeclarationsIn: aCCodeGen
	"Record C type declarations of the forms
		<returnTypeC: 'float'>
		<var: #foo declareC: 'float foo'>
		<var: #foo type:'float'>
		<var: #foo as: Class>
	 or the older, obsolete
		self returnTypeC: 'float'.
		self var: #foo declareC: 'float foo'
		self var: #foo type:'float'.
		self var: #foo as: Class
	 and remove the declarations from the method body."

	| newStatements |
	properties pragmas notEmpty ifTrue:
		[properties pragmas do:
			[:pragma|
			pragma keyword = #var:declareC: ifTrue:
				[self checkedDeclarationAt: pragma arguments first asString
					put: pragma arguments last
					in: aCCodeGen].
			pragma keyword = #var:type: ifTrue:
				[| varName varType |
				varName := pragma arguments first asString.
				varType := pragma arguments last.
				varType last = $* ifFalse: [varType := varType, ' '].
				self checkedDeclarationAt: varName
					put: varType, varName
					in: aCCodeGen].
			 pragma keyword = #var:as: ifTrue:
				[| theClass |
				 theClass := Smalltalk at: pragma arguments last name asSymbol ifAbsent: [nil].
				 (theClass isKindOf: Behavior) ifFalse:
					[^self error: 'declarator must be a Behavior'].
				 self checkedDeclarationAt: pragma arguments first value asString 
					put: (theClass ccgDeclareCForVar: pragma arguments first asString)
					in: aCCodeGen].
			pragma keyword = #returnTypeC: ifTrue:
				[self returnType: pragma arguments last].
			pragma keyword = #doNotGenerate: ifTrue:
				[locals removeKey: pragma arguments last]].
		^self].
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do: 
		[:stmt | | isDeclaration |
		 isDeclaration := false.
		 stmt isSend ifTrue: 
			[stmt selector = #var:declareC: ifTrue:
				[isDeclaration := true.
				self declarationAt: stmt args first value asString put: stmt args last value].
			stmt selector = #var:type: ifTrue: [
				| varName varType |
				isDeclaration := true.
				varName := stmt args first value asString.
				varType := stmt args last value.
				varType last = $* ifFalse: [varType := varType, ' '].
				self declarationAt: varName put: varType, varName.
			].
			 stmt selector = #var:as: ifTrue:
				[| theClass |
				 isDeclaration := true.
				 theClass := Smalltalk  at: stmt args last name asSymbol ifAbsent: [nil].
				 (theClass isKindOf: Behavior) ifFalse:
					[^self error: 'declarator must be a Behavior'].
				 self declarationAt: stmt args first value asString 
					put: (theClass ccgDeclareCForVar: stmt args first value asString)].
			 stmt selector = #returnTypeC: ifTrue: 
				[isDeclaration := true.
				 returnType := stmt args last value]].
		 isDeclaration ifFalse: [newStatements add: stmt]].
	parseTree setStatements: newStatements asArray