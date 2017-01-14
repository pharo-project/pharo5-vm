debug printing
printActivationNameForSelector: aSelector startClass: startClass
	super printActivationNameForSelector: aSelector startClass: startClass.
	"(self transcript dependents detect: [:d| d isTextView] ifNone: []) ifNotNil:
		[:textView| | text size |
		text := textView text asString.
		((size := text size) >= 30
		and: [(text copyFrom: size - 29 to: size) = 'Object(ProtoObject)>initialize']) ifTrue:
			[self doOrDefer: [self changed: #byteCountText; changed: #composeAll].
			 self halt]"