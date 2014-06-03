jit - api
cogitPostGCAction: gcMode
	<api>
	(gcMode = GCModeFull
	 and: [objectRepresentation allYoungObjectsAgeInFullGC]) ifTrue:
		[methodZone voidYoungReferrersPostTenureAll].
	"Post-GC update every full method's objectHeader to whatever it needs to be"
	self assert: self allMethodsHaveCorrectHeader.
	self assert: methodZone kosherYoungReferrers