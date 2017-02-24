comparing
isSameEntryAs: ssEntry
	<var: 'ssEntry' type: #'CogSimStackEntry *'>
	^type = ssEntry type
	  and: [((type = SSBaseOffset or: [type == SSSpill]) and: [offset = ssEntry offset and: [register = ssEntry register]])
		or: [(type = SSRegister and: [register = ssEntry register])
		or: [(type = SSConstant and: [constant = ssEntry constant])]]]