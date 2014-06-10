generate sources
generateAll
	"tell the vmMaker to build all the sources"
	self checkOK
		ifTrue: [[vmMaker generateEntire]
				on: VMMakerException
				do: [:ex| self inform: ex messageText]]