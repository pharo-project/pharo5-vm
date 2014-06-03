generate sources
generateCore
	"tell the vmMaker to build all the core vm sources"
	self checkOK
		ifTrue: [[vmMaker generateMainVM]
		on: VMMakerException
		do: [:ex| self inform: ex messageText]]