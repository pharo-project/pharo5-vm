control & support primitives
primGetModuleName
	"If calling this primitive fails, then C module does not exist."
	| strLen strOop strPtr |
	<var: #strPtr type: 'char *'>
	self debugCode: [self msg: 'primGetModuleName'].
	self
		primitive: 'primGetModuleName'
		parameters: #()
		receiver: #Oop.
	strLen := self strlen: self getModuleName.
	strOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: strLen.
	strPtr := interpreterProxy firstIndexableField: strOop.
	0 to: strLen - 1 do: [:i | strPtr at: i put: (self getModuleName at: i)].
	^strOop