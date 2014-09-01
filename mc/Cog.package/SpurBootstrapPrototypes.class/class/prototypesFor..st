instance creation
prototypesFor: type 
	^ (self allSubclasses 
		detect: [ :aClass | aClass imageType = type ])
		new
	