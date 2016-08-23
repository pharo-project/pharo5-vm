testing
isConditionalSend
	"Answer if the receiver is a send of any of the conditionals, ifTrue: ifTrue:ifFalse: et al"
	^#(	ifTrue:ifFalse: ifFalse:ifTrue: ifTrue: ifFalse:
		ifNil:ifNotNil: ifNotNil:ifNil: ifNil: ifNotNil) includes: selector