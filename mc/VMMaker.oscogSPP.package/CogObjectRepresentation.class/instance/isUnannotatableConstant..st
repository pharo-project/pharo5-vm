compile abstract instructions
isUnannotatableConstant: simStackEntry
	<inline: true>
	<var: 'simStackEntry' type: #'CogSimStackEntry *'>
	^simStackEntry type = SSConstant 
	  and: [(objectMemory isImmediate: simStackEntry constant)
		or: [(self shouldAnnotateObjectReference: simStackEntry constant) not]]