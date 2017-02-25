Component Mgr prims
primOpenDefaultConfiguration: type subtype: subtype

	| component |
	component := self	primitive: 	'primOpenDefaultConfiguration'
						parameters: #(DescType DescType)
						receiver:	#ComponentInstance.
	self	cCode: '*component = OpenDefaultComponent(*type,*subtype)'
		inSmalltalk: [component at: 0 put: 0].
	^component asOop: ComponentInstance