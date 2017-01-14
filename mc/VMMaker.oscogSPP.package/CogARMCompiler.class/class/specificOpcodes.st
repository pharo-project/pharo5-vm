class initialization
specificOpcodes
	"Answer the processor-specific opcodes for this class.
	 They're all in an Array literal in the initialize method."
	^(self class >> #initialize) literals detect: [:l| l isArray and: [l includes: #LDMFD]]