system startup
startUp: resuming 
	resuming ifFalse: [ ^ self ].
	self forgetUniqueInstance.
	self allSubclasses do: [ :each | each forgetUniqueInstance ]