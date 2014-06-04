OSA prims
primOSAScriptingComponentNameTo: anAEDesc

	|component|
	component := self	primitive: 	'primOSAScriptingComponentName'
						parameters: #(AEDesc)
						receiver:	#ComponentInstance.
	
	^(self cCode: 'OSAScriptingComponentName(*component,anAEDesc)'
			inSmalltalk: [[component]. -1]) asOop: Unsigned