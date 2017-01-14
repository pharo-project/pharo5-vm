C code generation
emitInlineOn: aStream level: level generator: aCodeGen
	"Emit C code for this method onto the given stream. All calls to inlined methods should already have been expanded."
	self removeUnusedTempsAndNilIfRequiredIn: aCodeGen.
	sharedLabel ifNotNil:
		[aStream crtab: level-1; nextPutAll: sharedLabel; nextPut: $:.
		aStream crtab: level.
		aStream nextPutAll: '/* '; nextPutAll: selector; nextPutAll: ' */'.
		aStream crtab: level].
	aStream nextPut: ${.
	locals isEmpty ifFalse:
		[(aCodeGen sortStrings: locals) do:
			[:var|
			 aStream
				crtab: level+1;
				nextPutAll: (self declarationAt: var);
				nextPut: $;].
			 aStream cr].
	aStream crtab: level+1.
	aCodeGen outputAsmLabel: selector on: aStream.
	aStream crtab: level+1.
	aCodeGen
		pushScope: declarations
		while: [parseTree emitCCodeOn: aStream level: level+1 generator: aCodeGen].
	aStream tab: level; nextPut: $}