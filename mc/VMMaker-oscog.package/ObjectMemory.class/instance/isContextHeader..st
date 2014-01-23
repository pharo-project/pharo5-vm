contexts
isContextHeader: aHeader
	<inline: true>
	"c.f. {BlockContext. MethodContext. PseudoContext} collect: [:class| class -> class indexIfCompact]"
	^ ((aHeader >> 12) bitAnd: 16r1F) = 13			"BlockContext"
		or: [((aHeader >> 12) bitAnd: 16r1F) = 14]	"MethodContext"