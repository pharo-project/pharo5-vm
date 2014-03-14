*ConfigurationOfCog-override
createRepository
	(self description isKindOf: MCRepository )
		ifTrue: [ ^ self description ]. 
	^ self project createRepository: self.
