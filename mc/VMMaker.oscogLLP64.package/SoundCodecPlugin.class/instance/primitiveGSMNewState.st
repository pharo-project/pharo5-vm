gsm 6.10 codec
primitiveGSMNewState

	| state |
	<export: true>
	state := interpreterProxy
				instantiateClass: interpreterProxy classByteArray
				indexableSize: self gsmStateBytes.
	self gsmInitState: state + interpreterProxy baseHeaderSize.
	interpreterProxy pop: 1 thenPush: state