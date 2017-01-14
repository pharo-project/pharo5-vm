remembered set
strategizeToLimitRememberedTable
	<inline: true>
	(tenureCriterion = TenureByAge
	 and: [rememberedSetSize >= rememberedSetRedZone]) ifTrue:
		[tenureCriterion := TenureToShrinkRT.
		 self computeRefCountToShrinkRT]