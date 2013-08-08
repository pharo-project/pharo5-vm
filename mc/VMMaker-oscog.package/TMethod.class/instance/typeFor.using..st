utilities
typeFor: aVariable using: aCCodeGen
	"Answer the type for aVariable.  Answer nil for variables without types.  nil for
	 typelessness is required by the type propagation logic in inlineSend:directReturn:exitVar:in:."
	^aCCodeGen extractTypeFor: aVariable fromDeclaration: (declarations at: aVariable asString ifAbsent: [^nil])