OSA prims
primOSALoad: source mode: mode to: result

	|component|
	component := self primitive: 	'primOSALoad'
					parameters: #(AEDesc SmallInteger OSAID)
					receiver:	#ComponentInstance.

	^(self cCode: 'OSALoad(*component,source,mode,result)'
			inSmalltalk: [[component]. -1]) asOop: Unsigned