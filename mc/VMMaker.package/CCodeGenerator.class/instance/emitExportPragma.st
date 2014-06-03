C code generator
emitExportPragma
	"Controls emission of  #pragma export on / #pragma export off,
	 which is not relevant to any current platform that anyone could name."
	^[vmClass emitExportPragma]
		on: MessageNotUnderstood
		do: [:ex| false]