OSA prims
primOSAGetScriptInfo: aScriptID type: aDescType to: resultData

	|component|
	component := self	primitive: 	'primOSAGetScriptInfo'
						parameters: #(OSAID DescType IntegerArray)
						receiver:	#ComponentInstance.
	
	^(self cCode: 'OSAGetScriptInfo(*component,*aScriptID,*aDescType, (long *)resultData)'
			inSmalltalk: [[component]. -1]) asOop: Unsigned