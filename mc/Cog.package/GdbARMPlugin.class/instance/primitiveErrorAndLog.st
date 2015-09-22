primitives
primitiveErrorAndLog
	| log logLen resultObj logObj logObjData |
	<var: #log type: #'char *'>
	<var: #logObjData type: #'char *'>
	self primitive: #primitiveErrorAndLog parameters: #().

	log := self getlog: (self cCode: [self addressOf: logLen] inSmalltalk: [logLen := 0]).
	resultObj := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2.
	resultObj = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoMemory].

	interpreterProxy
		storePointer: 0
		ofObject: resultObj
		withValue: (interpreterProxy integerObjectOf: self errorAcorn).

	logLen > 0 ifTrue:
		[interpreterProxy pushRemappableOop: resultObj.
		logObj := interpreterProxy
					instantiateClass: interpreterProxy classString
					indexableSize: logLen.
		interpreterProxy failed ifTrue:
			[interpreterProxy popRemappableOop.
			 ^interpreterProxy primitiveFailFor: PrimErrNoMemory].

		resultObj := interpreterProxy popRemappableOop.
		logObjData := interpreterProxy arrayValueOf: logObj.
		self mem: logObjData cp: log y: logLen.
		interpreterProxy storePointer: 1 ofObject: resultObj withValue: logObj].
	interpreterProxy pop: 1 thenPush: resultObj