OSA prims
primOSADisplay: source as: type mode: mode to: result

	|component|
	component := self primitive: 	'primOSADisplay'
					parameters: #(OSAID DescType SmallInteger AEDesc)
					receiver:	#ComponentInstance.

	^(self cCode: 'OSADisplay(*component,*source,*type,mode,result)'
			inSmalltalk: [[component]. -1]) asOop: Unsigned