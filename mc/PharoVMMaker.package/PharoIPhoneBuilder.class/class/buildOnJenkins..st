building
buildOnJenkins: aPlatformName
	"entry point for jenkins build jobs.
	currently we use following names:
		win
		mac
		linux
	
	"
	
	aPlatformName = 'iPhone' ifTrue: [ ^ self buildIPhone ].
	aPlatformName = 'iPhoneSimulator' ifTrue: [ ^ self buildIPhoneSimulator ].
	
	self error: 'no suitable platform'