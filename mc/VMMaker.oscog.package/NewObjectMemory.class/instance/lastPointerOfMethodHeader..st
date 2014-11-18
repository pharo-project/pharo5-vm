object enumeration
lastPointerOfMethodHeader: methodHeader 
	"Answer the byte offset of the last pointer field of a
	 CompiledMethod with the given header.  Use a temp to
	 allow inlining given MULTIPLEBYTECODESETS complications."
	<inline: true>
	| numLiterals |
	numLiterals := self literalCountOfMethodHeader: methodHeader.
	^numLiterals + LiteralStart - 1 * self bytesPerOop + self baseHeaderSize