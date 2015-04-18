compile abstract instructions
isUnannotatableConstant: simStackEntry
	<inline: true>
	^ simStackEntry type = SSConstant 
		and: [(self shouldAnnotateObjectReference: simStackEntry constant) not ]