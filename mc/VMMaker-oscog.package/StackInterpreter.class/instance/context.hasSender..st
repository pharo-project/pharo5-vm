internal interpreter access
context: thisCntx hasSender: aContext 
	"Does thisCntx have aContext in its sender chain?
	 Cheapo implementation above extant machinery."
	| handlerOrNilOrZero |
	<inline: true>
	handlerOrNilOrZero := self
							findMethodWithPrimitive: -1
							FromContext: thisCntx
							UpToContext: aContext.
	^handlerOrNilOrZero == 0