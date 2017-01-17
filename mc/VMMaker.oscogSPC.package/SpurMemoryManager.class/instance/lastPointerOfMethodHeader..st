object enumeration
lastPointerOfMethodHeader: methodHeader 
	"Answer the byte offset of the last pointer field of a
	 CompiledMethod with the given header."
	<inline: true>
	^(self literalCountOfMethodHeader: methodHeader)
	  + LiteralStart - 1 * self bytesPerOop + self baseHeaderSize