Gen'l Mac OS prims
primGetHandleSize: anIndex

	|rcvr|
	rcvr := self	primitive: 'primGetHandleSize'
				parameters: #(SmallInteger)
				receiver:	#WordArray.
	^(self
		cCode: 'GetHandleSize((Handle) *(rcvr+anIndex))'
		inSmalltalk: [[rcvr]. -1]) asOop: Unsigned