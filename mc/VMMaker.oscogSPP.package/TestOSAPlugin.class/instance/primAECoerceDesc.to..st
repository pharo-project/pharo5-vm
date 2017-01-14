AppleEvents prims
primAECoerceDesc: typeCode to: result

	|rcvr |
	rcvr := self 	primitive: 	'primAECoerceDesc'
				parameters:	#(DescType AEDesc)
				receiver:	#AEDesc.
	^(self 
		cCode: 'AECoerceDesc(rcvr,*typeCode,result)'
		inSmalltalk: [[rcvr]. -1]) asOop: Unsigned