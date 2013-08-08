generate sources
generateExternal
	"tell the vmMaker to build all the externally linked plugin sources"
	self checkOK
		ifTrue: [[vmMaker generateExternalPlugins]
		on: VMMakerException
		do: [:ex | self inform: ex messageText]]