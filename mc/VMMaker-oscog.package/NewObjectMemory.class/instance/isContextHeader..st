internal interpreter access
isContextHeader: aHeader
	<inline: true>
	"c.f. {BlockContext. MethodContext. PseudoContext} collect: [:class| class -> class indexIfCompact]"
	^(self compactClassIndexOfHeader: aHeader) = ClassMethodContextCompactIndex