version
primVersionNO
	"majorNO * 1000 + minorNO"
	self
		primitive: 'primVersionNO'
		parameters: #()
		receiver: #Oop.
	^ (self majorNO * 1000 + self minorNO) asOop: SmallInteger