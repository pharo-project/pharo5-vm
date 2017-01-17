scavenger
shouldMournerBeTenured: survivor
	"Answer if an object in the mourn queue should be tenured.  If we're
	 in the good times tenuring regime then copy to futureSpace, otherwise tenure."
	^(tenureCriterion = TenureByAge and: [tenureThreshold = 0]) not