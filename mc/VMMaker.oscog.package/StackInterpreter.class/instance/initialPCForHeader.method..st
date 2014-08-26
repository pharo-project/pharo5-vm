compiled methods
initialPCForHeader: methodHeader method: theMethod
	"Answer the initial PC for a method; used only in methods that build a frame.
	 Hence add an assert to check that there's a sane methodClassAssociation."
	<inline: true>
	self assert: (self saneMethodClassAssociationIn: theMethod
					numLiterals: (objectMemory literalCountOfMethodHeader: methodHeader)).
	^theMethod
	+ ((LiteralStart + (objectMemory literalCountOfMethodHeader: methodHeader)) * BytesPerOop)
	+ objectMemory baseHeaderSize