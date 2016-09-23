source generation
vmMakerOptions
	"Indicates we are building a pharovm (even if name is not pharo... like cogvm. etc. It uses our 
	 plugins versions, flags, etc."
	"^ #( PharoVM true )"
	self flag: #important. "For the purpose of generating sources, I need to keep PharoVM=false 
	(otherwise non-pharo VMs will generate bad... this is like this since we migrated to 
	OpenSmalltalkVM process)"
	^ #()