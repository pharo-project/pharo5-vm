compile abstract instructions
maybeAnnotateUse: inst
	<inline: true>
	annotateUse ifTrue:
		[inst annotation = 0
			ifTrue: [cogit annotateBytecode: inst]
			ifFalse: [cogit annotateBytecode: cogit Label].
		 annotateUse := false]