obsolete
primCheckIfCModuleExists
	"If calling this primitive fails, then C module does not exist. Do not check for forced fail, because we want to know if module exists during forced fail, too."
	self
		primitive: 'primCheckIfCModuleExists'
		parameters: #()
		receiver: #Oop.
	^ true asOop: Boolean