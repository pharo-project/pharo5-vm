C code generation
emitCCodeOn: aStream generator: aCodeGen
	"Emit C code for this method onto the given stream.
	 All calls to inlined methods should already have been expanded."
	| conditional |

	aCodeGen currentMethod: self.
	self emitCCommentOn: aStream.	"place method comment and method name before function."
	aStream crtab; nextPutAll: '/* '; nextPutAll: self definingClass name; nextPutAll: '>>#'; nextPutAll: self smalltalkSelector; nextPutAll: ' */'.	
	aStream cr. 
	conditional := self emitCFunctionPrototype: aStream generator: aCodeGen isPrototype: false.
	aStream cr; nextPut: ${.
	self emitCLocalsOn: aStream generator: aCodeGen.
	aCodeGen
		pushScope: declarations
		while: [parseTree emitCCodeOn: aStream level: 1 generator: aCodeGen].
	(returnType = #void or: [parseTree endsWithReturn]) ifFalse:
		[aStream tab; nextPutAll: 'return 0;'; cr].
	aStream nextPut: $}; cr.
	conditional ifTrue:
		[self terminateConditionalDefineFor: self compileTimeOptionPragmas on: aStream]