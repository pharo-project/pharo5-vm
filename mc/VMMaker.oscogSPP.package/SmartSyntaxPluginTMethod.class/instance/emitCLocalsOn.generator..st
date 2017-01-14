C code generation
emitCLocalsOn: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	aStream cr.
	locals isEmpty ifFalse:
		[(aCodeGen sortStrings: locals) do:
			[ :var |
		aStream 
			tab; 
			nextPutAll: (self declarationAt: var);
			nextPut: $;; 
			cr].
		 aStream cr]