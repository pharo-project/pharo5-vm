testing
definedAsMacro
	^properties notNil
	  and: [(properties includesKey: #cmacro:)
		or: [properties includesKey: #cmacro]]