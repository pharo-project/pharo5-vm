gsm 6.10 codec
primitiveGSMNewState

	| state |
	<export: true>
	state := interpreterProxy
				instantiateClass: interpreterProxy classByteArray
				indexableSize: self gsmStateBytes.
	self gsmInitState: state + BaseHeaderSize.
	interpreterProxy pop: 1 thenPush: state