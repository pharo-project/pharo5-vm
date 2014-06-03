utilities
anyMethodNamed: selector
	"Answer any method in the code base (including api methods) with the given selector."

	^methods
		at: selector
		ifAbsent:
			[apiMethods ifNotNil:
				[apiMethods
					at: selector
					ifAbsent: []]]