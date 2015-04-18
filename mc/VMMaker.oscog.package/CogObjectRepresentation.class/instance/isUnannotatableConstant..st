compile abstract instructions
isUnannotatableConstant: simStackEntry
	<inline: true>
	<var: 'simStackEntry' type: #'CogSimStackEntry *'>
	^ simStackEntry type = SSConstant 
		and: [(self shouldAnnotateObjectReference: simStackEntry constant) not ]