OSA prims
primOSAStore: source resultType: type mode: mode to: result

	|component|
	component := self primitive: 	#primOSAStore
					parameters: #(OSAID DescType SmallInteger AEDesc)
					receiver:	#ComponentInstance.

	^(self cCode: 'OSAStore(*component,*source,*type,mode,result)'
			inSmalltalk: [[component]. -1]) asOop: Unsigned