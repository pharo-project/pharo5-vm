contexts
isContextHeader: aHeader
	<inline: true>
	"c.f. {BlockContext. MethodContext. PseudoContext} collect: [:class| class -> class indexIfCompact]"
	^(self compactClassIndexOf: aHeader) = 13			"BlockContext"
		or: [(self compactClassIndexOf: aHeader) = 14]		"MethodContext"