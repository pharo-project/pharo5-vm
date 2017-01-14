menus
platformNameText: aText 
	"set the platform name - this will almost certainly mean replacing the  
	vmMaker with one suited to the platform so we do it anyway."
	| prevVMMaker newVMMaker |
	prevVMMaker := vmMaker.
	"make a new vmmaker and ensure I depend on it correctly"
	newVMMaker := VMMaker forPlatform: aText string.
	newVMMaker logger: logger.
	"configure the new vmmaker to match the old one"
	[newVMMaker loadConfiguration: prevVMMaker configurationInfo.
	 newVMMaker platformDirectory]
		on: VMMakerException
		do: [self inform: 'Possible problem with path settings or platform name? Check path, permissions or spellings'.
			^false].
	newVMMaker addDependent: self.
	prevVMMaker removeDependent: self.
	vmMaker := newVMMaker.
	^true