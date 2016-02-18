repository population
repositoryForUrl: url
	^MCRepositoryGroup default repositories 
		detect: [:r| r description = url]
		ifNone: [MCHttpRepository
					location: url
					user: 'squeak'
					password: 'squeak']