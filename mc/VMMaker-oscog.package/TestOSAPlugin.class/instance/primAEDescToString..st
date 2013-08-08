AppleEvents prims
primAEDescToString: aString

	| rcvr size |
	rcvr := self	primitive: 	'primAEDescToString'
				parameters: #(String)
				receiver: #AEDesc.
	size := aString size.
	self cCode: 'BlockMove(*(rcvr->dataHandle), aString, size)'
		 inSmalltalk: [rcvr. size].
	^aString asOop: String

