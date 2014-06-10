repository population
spur
	| url |
	url := 'http://source.squeak.org/spur'.
	^MCRepositoryGroup default repositories 
		detect: [:r| r description = url]
		ifNone:
			[MCHttpRepository fillInTheBlankConfigure:
				(MCHttpRepository
					creationTemplateLocation: url
					user: 'user with write permission'
					password: 'password')]