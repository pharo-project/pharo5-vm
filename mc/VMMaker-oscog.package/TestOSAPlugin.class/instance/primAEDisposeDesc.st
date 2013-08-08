AppleEvents prims
primAEDisposeDesc
	
	|rcvr|
	rcvr :=	self	primitive: 	'primAEDisposeDesc'
				parameters:	#()
				receiver: 	#AEDesc.
	^(self 
		cCode: 'AEDisposeDesc(rcvr)'
		inSmalltalk: [[rcvr]. -1]) asOop: Unsigned