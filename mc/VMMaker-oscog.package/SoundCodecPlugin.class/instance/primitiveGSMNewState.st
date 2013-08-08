gsm 6.10 codec
primitiveGSMNewState

	| stateBytes state |
	<export: true>
	stateBytes := self cCode: 'gsmStateBytes()'.
	state := interpreterProxy
		instantiateClass: interpreterProxy classByteArray
		indexableSize: stateBytes.
	self cCode: 'gsmInitState(state + 4)'.
	interpreterProxy pop: 1.
	interpreterProxy push: state.
