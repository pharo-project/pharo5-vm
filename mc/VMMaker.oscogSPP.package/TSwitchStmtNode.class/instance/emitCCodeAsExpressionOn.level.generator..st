C code generation
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	"Emit the receiver as an if-the-else chain."
	| varName n |
	self assert: (expression isVariable or: [switchVariable notNil]).
	aStream nextPut: $(.
	switchVariable
		ifNil: [varName := String streamContents: [:s| expression emitCCodeOn: s level: 0 generator: aCodeGen].
			aStream nextPutAll: varName]
		ifNotNil:
			[varName := switchVariable.
			 aStream nextPut: $(; nextPutAll: varName; nextPutAll: ' = '.
			 expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
			 aStream nextPut: $)].
	n := 0.
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 n > 0 ifTrue:
				[aStream nextPutAll: varName].
			 aStream nextPutAll: ' == '.
			 label emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			 aStream nextPut: $).
			 aStream crtab: level + n + 1.
			 aStream nextPutAll: '? ('.
			 (TStmtListNode new setArguments: #() statements: case statements)
			 	emitCCodeAsArgumentOn: aStream
				level: level + 2
				generator: aCodeGen.
			 aStream nextPut: $); crtab: level + n + 1; nextPutAll: ': ('.
			 n := n + 1]]
			valueWithArguments: tuple].
	otherwiseOrNil
		ifNotNil: [otherwiseOrNil emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause"), 0'].
	aStream next: n - 1 put: $)