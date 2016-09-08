scavenger
shouldBeTenured: survivor
	"Answer if an object should be tenured.  The default policy tenuring policy
	 is to use the tenuringThreshold to decide. If the survivors (measured in
	 bytes) are above some fraction of the survivor space then objects below
	 the threshold (older objects, since allocation grows upwards and hence
	 new objects are later than old) are scavenged.  Otherwise, the threshold
	 is set to 0 and no objects are tenured.  e.g. see
		An adaptive tenuring policy for generation scavengers,
		David Ungar & Frank Jackson.
		ACM TOPLAS, Volume 14 Issue 1, Jan. 1992, pp 1 - 27.

	 The other policies are for special purposes."
	^tenureCriterion
		caseOf: {
			[TenureByAge]	->
				[survivor < tenureThreshold]. 
			[TenureByClass] ->
				[(manager classIndexOf: survivor) = tenuringClassIndex].
			[TenureToShrinkRT]	->
				[(manager rtRefCountOf: survivor) >= refCountToShrinkRT]  }
		otherwise: [false]