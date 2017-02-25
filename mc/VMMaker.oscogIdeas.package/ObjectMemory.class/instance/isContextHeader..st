contexts
isContextHeader: aHeader
	<inline: true>
	"c.f. {BlockContext. MethodContext. PseudoContext} collect: [:class| class -> class indexIfCompact]"
	^(self compactClassIndexOfHeader: aHeader) = 13			"BlockContext"
		or: [(self compactClassIndexOfHeader: aHeader) = 14]		"MethodContext"