C code generation
emitCLocalsOn: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	| volatileVariables |
	volatileVariables := properties includesKey: #volatile.
	self refersToGlobalStruct ifTrue:
		[aStream
			next: 3 put: Character space; "there's already an opening ${ on this line; see sender"
			nextPutAll: (volatileVariables
						ifTrue: ['DECL_MAYBE_VOLATILE_SQ_GLOBAL_STRUCT']
						ifFalse: ['DECL_MAYBE_SQ_GLOBAL_STRUCT'])].
	aStream cr.
	locals isEmpty ifFalse:
		[(aCodeGen sortStrings: locals) do:
			[ :var |
			aStream next: 4 put: Character space.
			volatileVariables ifTrue:
				[aStream nextPutAll: #volatile; space].
			aStream
				nextPutAll: (self declarationAt: var);
				nextPut: $;;
				cr].
		 aStream cr]