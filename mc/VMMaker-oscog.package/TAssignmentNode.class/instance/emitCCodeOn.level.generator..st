C code generation
emitCCodeOn: aStream level: level generator: aCodeGen
	expression isSwitch ifTrue:
		[^expression emitCCodeOn: aStream addToEndOfCases: self level: level generator: aCodeGen].
	expression isLiteralArrayDeclaration ifTrue:
		[^self emitLiteralArrayDeclarationOn: aStream level: level generator: aCodeGen].
	variable emitCCodeOn: aStream level: level generator: aCodeGen.
	self isVariableUpdatingAssignment
		ifTrue:
			[aStream
				space;
				nextPutAll: expression selector;	"+ or -"
				nextPut: $=;
				space.
			expression args first emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen]
		ifFalse:
			[aStream space; nextPut: $=; space.
			 expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen]