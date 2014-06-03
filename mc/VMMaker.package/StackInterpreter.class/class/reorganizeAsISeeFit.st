miscellaneous
reorganizeAsISeeFit
	"StackInterpreter reorganizeAsISeeFit"
	"CoInterpreter reorganizeAsISeeFit"
	| initializations bytecodes privates remainder |
	initializations := OrderedCollection new.
	bytecodes := OrderedCollection new.
	privates := OrderedCollection new.
	remainder := OrderedCollection new.
	self organization categories do:
		[:cat|
		((cat includesSubString: 'initializ')
			ifTrue: [initializations]
			ifFalse:
				[((cat endsWith: 'bytecodes') or: [cat includesSubString: 'selector sends'])
					ifTrue: [bytecodes]
					ifFalse:
						[(cat includesSubString: 'private')
							ifTrue: [privates]
							ifFalse: [remainder]]])
			add: cat].
	self organization categories: initializations sort, bytecodes sort, remainder sort, privates sort