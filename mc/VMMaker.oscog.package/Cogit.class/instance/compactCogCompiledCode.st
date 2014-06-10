jit - api
compactCogCompiledCode
	<api>
	self assert: self noCogMethodsMaximallyMarked.
	coInterpreter markActiveMethodsAndReferents.
	methodZone freeOlderMethodsForCompaction.
	self freePICsWithFreedTargets.
	methodZone planCompaction.
	coInterpreter updateStackZoneReferencesToCompiledCodePreCompaction.
	self relocateMethodsPreCompaction.
	methodZone compactCompiledCode.
	self assert: self allMethodsHaveCorrectHeader.
	self assert: methodZone kosherYoungReferrers.
	processor flushICacheFrom: methodZoneBase to: methodZone freeStart