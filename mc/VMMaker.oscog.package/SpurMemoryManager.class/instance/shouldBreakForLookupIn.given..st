debug support
shouldBreakForLookupIn: lookupClass given: breakClassTag
	<inline: true>
	^breakClassTag notNil
	  and: [lookupClass == breakClassTag
			or: [(self rawHashBitsOf: lookupClass) == breakClassTag]]