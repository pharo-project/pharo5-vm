testing
ssTopNeedsStoreCheck
	<inline: true>
	^self ssTop type ~= SSConstant
	  or: [(objectMemory isNonImmediate: self ssTop constant)
		and: [objectRepresentation shouldAnnotateObjectReference:  self ssTop constant]]