control & support primitives
primGetModuleName
	"If calling this primitive fails, then C module does not exist."
	| strLen strOop |
	self debugCode: [self msg: 'primGetModuleName'].
	self
		primitive: 'primGetModuleName'
		parameters: #()
		receiver: #Oop.
	strLen := self strlen: self getModuleName.
	strOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: strLen.
	self st: (interpreterProxy firstIndexableField: strOop)
		rn: self getModuleName
		cpy: strLen.
	^strOop