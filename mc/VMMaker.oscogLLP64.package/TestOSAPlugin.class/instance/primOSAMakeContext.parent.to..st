OSA prims
primOSAMakeContext: name parent: parent to: result

	|component|
	component := self primitive: 	#primOSAMakeContext
					parameters: #(AEDesc OSAID OSAID)
					receiver:	#ComponentInstance.

	^(self cCode: 'OSAMakeContext(*component,name,*parent,result)'
			inSmalltalk: [[component]. -1]) asOop: Unsigned