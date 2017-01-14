GET processing
initializeGETProcessing
	"Initialization stuff that needs to be done before any processing can take place."
	<inline: false>

	"Make sure aaLevel is initialized"
	self setAALevel: self aaLevelGet.

	self clipMinXGet < 0 ifTrue:[self clipMinXPut: 0].
	self clipMaxXGet > self spanSizeGet ifTrue:[self clipMaxXPut: self spanSizeGet].
	"Convert clipRect to aaLevel"
	self fillMinXPut: self clipMinXGet << self aaShiftGet.
	self fillMinYPut: self clipMinYGet << self aaShiftGet.
	self fillMaxXPut: self clipMaxXGet << self aaShiftGet.
	self fillMaxYPut: self clipMaxYGet << self aaShiftGet.

	"Reset GET and AET"
	self getUsedPut: 0.
	self aetUsedPut: 0.
	getBuffer := objBuffer + objUsed.
	aetBuffer := objBuffer + objUsed.

	"Create the global edge table"
	self createGlobalEdgeTable.
	engineStopped ifTrue:[^nil].

	self getUsedGet = 0 ifTrue:[
		"Nothing to do"
		self currentYPut: self fillMaxYGet.
		^0].

	"Sort entries in the GET"
	self sortGlobalEdgeTable.

	"Find the first y value to be processed"
	self currentYPut: (self edgeYValueOf: (getBuffer at: 0)).
	self currentYGet < self fillMinYGet ifTrue:[self currentYPut: self fillMinYGet].

	"Load and clear the span buffer"
	self spanStartPut: 0.
	self spanEndPut: (self spanSizeGet << self aaShiftGet) - 1.
	self clearSpanBuffer. "@@: Is this really necessary?!"