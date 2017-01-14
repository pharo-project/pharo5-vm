AppleEvents prims
primAEGetKeyPtr: key type: type actual: ignoreDesc to: bytes

	| rcvr size ignoreSize |
	<var: #ignoreSize type: 'Size '>
	rcvr := self	primitive: 	'primAEGetKeyPtr'
				parameters: #(DescType DescType DescType ByteArray)
				receiver: #AEDesc.
	size := ignoreSize := bytes size.
	^(self cCode: 'AEGetKeyPtr(rcvr, *key, *type, ignoreDesc, bytes, size, &ignoreSize)'
		 inSmalltalk: [[rcvr. size. ignoreSize]. -1]) asOop: Unsigned