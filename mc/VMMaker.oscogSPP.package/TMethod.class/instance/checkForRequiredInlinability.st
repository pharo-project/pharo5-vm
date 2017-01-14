testing
checkForRequiredInlinability
	"This is used in methods answering inlinability.
	 Always answer false.  But if the receiver is marked as something that must be inlined (inline == #always) raise an error."
	(inline == #always and: [complete]) ifTrue:
		[self error: 'cannot inline method ', selector, ' marked as <inline: #always>'].
	^false