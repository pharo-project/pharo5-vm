testing
isAPIMethod
	^properties notNil
	  and: [(properties includesKey: #api)
			or: [properties includesKey: #api:]]