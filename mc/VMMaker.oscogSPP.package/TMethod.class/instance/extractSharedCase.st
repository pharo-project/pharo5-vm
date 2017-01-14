transformations
extractSharedCase
	"Scan the pragmas for an shared case directive of the form:
		<sharedCodeNamed: 'sharedLabel' inCase: 'sharedCase'.>
		<sharedCodeInCase: 'sharedCase'.>
	or the older top-level statements for the form
		self sharedCodeNamed: 'sharedLabel' inCase: 'sharedCase'.
		self sharedCodeInCase: 'sharedCase'.
	in which case remove the directive from the method body."

	self extractDirective: #sharedCodeNamed:inCase:
		valueBlock: [:sendNode|
			args isEmpty ifFalse:
				[self error: 'Cannot share code sections in methods with arguments'].
			sharedLabel := sendNode args first value.
			sharedCase := sendNode args last value]
		default: nil.
	self extractDirective: #sharedCodeInCase:
		valueBlock: [:sendNode|
			args isEmpty ifFalse:
				[self error: 'Cannot share code sections in methods with arguments'].
			sharedLabel := selector.
			sharedCase := sendNode args last value]
		default: nil