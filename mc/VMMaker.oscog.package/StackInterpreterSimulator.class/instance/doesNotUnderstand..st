error handling
doesNotUnderstand: aMessage
	"If this is a doit and the objectMemory understands, pass it on."
	(thisContext findContextSuchThat: [:ctxt| ctxt selector == #evaluate:in:to:notifying:ifFail:logged:]) ifNotNil:
		[(objectMemory class whichClassIncludesSelector: aMessage selector) ifNotNil:
			[:implementingClass|
			(implementingClass inheritsFrom: Object) ifTrue: "i.e. VMClass and below"
				[thisContext sender selector ~~ #DoIt ifTrue:
					[Transcript nextPutAll: 'warning: redirecting ', aMessage selector, ' in ', thisContext sender printString, ' to objectMemory'; cr; flush].
				 aMessage lookupClass: nil.
				^aMessage sentTo: objectMemory]]].
	^super doesNotUnderstand: aMessage