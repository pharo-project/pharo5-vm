transformations
extractSharedCase
	"Scan the top-level statements for an shared case directive of the form:

		self sharedCodeNamed: <sharedLabel> inCase: <sharedCase>.

	and remove the directive from the method body."

	self extractDirective: #sharedCodeNamed:inCase:
		valueBlock: [:sendNode|
			args isEmpty ifFalse:
				[self error: 'Cannot share code sections in methods with arguments'].
			sharedLabel := sendNode args first value.
			sharedCase := sendNode args last value]
		default: nil