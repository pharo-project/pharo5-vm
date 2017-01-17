OSA prims
primOSACompile: source mode: mode to: object

	|component|
	component := self primitive: 	'primOSACompile'
					parameters: #(AEDesc SmallInteger OSAID)
					receiver:	#ComponentInstance.

	^(self cCode: 'OSACompile(*component,source,mode,object)'
			inSmalltalk: [[component]. -1]) asOop: Unsigned