bytecode generator support
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: false>
	self genStorePop: popBoolean LiteralVariable: litVarIndex needsStoreCheck: self ssTopNeedsStoreCheck.
	^ 0
		