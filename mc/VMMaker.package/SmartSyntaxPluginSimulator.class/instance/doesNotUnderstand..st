message forwarding
doesNotUnderstand: aMessage
	| signature selector parameters result |
	signature := signatureMap
					at: aMessage selector
					ifAbsent: [^super doesNotUnderstand: aMessage].
	selector := signature first.
	parameters := signature second.
	signature third "receiver block" value: (interpreterProxy stackValue: parameters size).
	interpreterProxy failed ifTrue:
		[^nil].
	result := [actualPlugin
					perform: selector
					withArguments: (parameters withIndexCollect:
										[:block :index|
										block value: (interpreterProxy stackValue: parameters size - index)])]
					on: Notification
					do: [:ex|
						ex tag == #getSimulator
							ifTrue: [ex resume: self]
							ifFalse: [ex pass]].
	interpreterProxy failed ifTrue:
		[^nil].
	interpreterProxy
		pop: interpreterProxy methodArgumentCount + 1
		thenPush: result.
	^nil "SmartSyntaxPluginPrimitives return null"