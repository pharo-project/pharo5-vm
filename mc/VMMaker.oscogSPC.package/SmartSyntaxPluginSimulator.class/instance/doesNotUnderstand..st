message forwarding
doesNotUnderstand: aMessage
	| signature selector parameters result |
	signature := signatureMap
					at: aMessage selector
					ifAbsent: [^super doesNotUnderstand: aMessage].
	self log: [interpreterProxy coInterpreter printExternalHeadFrame; print: aMessage selector; cr].
	selector := signature first.
	parameters := signature second.
	signature third "receiver block" value: (interpreterProxy stackValue: parameters size).
	interpreterProxy failed ifTrue:
		[self log: 'failed in marshalling'.
		 ^nil].
	result := [actualPlugin
					perform: selector
					withArguments: (parameters withIndexCollect:
										[:block :index|
										block value: (interpreterProxy stackValue: parameters size - index)])]
					on: Notification
					do: [:ex|
						ex tag == #getInterpreter ifTrue: [ex resume: interpreterProxy] ifFalse:
						[ex tag == #getSimulator ifTrue: [ex resume: self]
							ifFalse: [ex pass]]].
	interpreterProxy failed ifTrue:
		[self log: 'failed in execution'.
		 ^nil].
	result == actualPlugin ifTrue:
		[self log: '^self'.
		 interpreterProxy pop: interpreterProxy methodArgumentCount.
		 ^nil].
	self log: [interpreterProxy coInterpreter print: '^'; shortPrintOop: result; flush].
	interpreterProxy
		pop: interpreterProxy methodArgumentCount + 1
		thenPush: result.
	^nil "SmartSyntaxPluginPrimitives return null"