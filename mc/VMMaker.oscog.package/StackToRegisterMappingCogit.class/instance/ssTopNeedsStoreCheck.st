bytecode generator support
ssTopNeedsStoreCheck
	<inline: true>
	^ (objectRepresentation isUnannotatableConstant: self ssTop) not