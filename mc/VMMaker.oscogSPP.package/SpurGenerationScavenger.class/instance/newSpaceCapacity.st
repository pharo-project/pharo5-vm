accessing
newSpaceCapacity
	<inline: false>
	<returnTypeC: #usqInt>
	^eden limit - (futureSpace start min: pastSpace start)