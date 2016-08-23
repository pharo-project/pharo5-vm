jit - api
cogitPostGCAction: gcMode
	<api>
	(gcMode = GCModeFull
	 and: [objectRepresentation allYoungObjectsAgeInFullGC]) ifTrue:
		[methodZone voidYoungReferrersPostTenureAll].
	self cppIf: SPURVM ifTrue:
		[gcMode = GCModeBecome ifTrue:
			[methodZone followForwardedLiteralsInOpenPICList]].
	"Post-GC update every full method's objectHeader to whatever it needs to be"
	self assert: self allMethodsHaveCorrectHeader.
	"The youngReferrers should be correct after a GC since that is the point at which it is
	 pruned.  But at other times false positives or free methods on the list are acceptable."
	self assert: ((gcMode noMask: GCModeFull+GCModeNewSpace) or: [methodZone kosherYoungReferrers])