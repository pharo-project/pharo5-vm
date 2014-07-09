platform support
onCog: cogSpecificBlock else: general
	^ (Smalltalk vm isRunningCogit)
		ifTrue:  [cogSpecificBlock value]
		ifFalse: [general value]