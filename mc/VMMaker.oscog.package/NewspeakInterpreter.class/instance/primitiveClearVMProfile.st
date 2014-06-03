process primitives
primitiveClearVMProfile
	"Primitive. Void the VM profile histograms."
	self cCode: 'ioClearProfile()'.
	self pop: argumentCount