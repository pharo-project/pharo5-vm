accessing
defaultVMMakerOptions
	"An array of keypairs with default VMMaker options (generation will be initialized with through 
	 Cogit class>>#initializeWithOptions:"
	^ #(
	"Indicates we are building a pharovm (even if name is not pharo... like cogvm. etc. It uses our 
	 plugins versions, flags, etc."
	PharoVM true 
	)