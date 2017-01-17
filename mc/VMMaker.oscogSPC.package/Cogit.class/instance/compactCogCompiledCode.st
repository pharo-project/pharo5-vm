jit - api
compactCogCompiledCode
	<api>
	self assert: self noCogMethodsMaximallyMarked.
	coInterpreter markActiveMethodsAndReferents.
	methodZone freeOlderMethodsForCompaction.
	self compactPICsWithFreedTargets.
	methodZone planCompaction.
	coInterpreter updateStackZoneReferencesToCompiledCodePreCompaction.
	methodZone relocateMethodsPreCompaction.
	methodZone compactCompiledCode.
	self assert: self allMethodsHaveCorrectHeader.
	self assert: methodZone kosherYoungReferrers.
	backEnd stopsFrom: methodZone freeStart to: methodZone youngReferrers - 1.
	processor
		flushICacheFrom: methodZoneBase asUnsignedInteger
		to: methodZone youngReferrers asUnsignedInteger