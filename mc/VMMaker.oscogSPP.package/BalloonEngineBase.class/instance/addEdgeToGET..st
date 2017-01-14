GET processing
addEdgeToGET: edge
	<inline: false>
	(self allocateGETEntry: 1) ifFalse:[^0].
	"Install edge in the GET"
	getBuffer at: self getUsedGet put: edge.
	self getUsedPut: self getUsedGet + 1.