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
		((cat includesSubstring: 'initializ')
			ifTrue: [initializations]
			ifFalse:
				[((cat endsWith: 'bytecodes') or: [cat includesSubstring: 'selector sends'])
					ifTrue: [bytecodes]
					ifFalse:
						[(cat includesSubstring: 'private')
							ifTrue: [privates]
							ifFalse: [remainder]]])
			add: cat].
	self organization categories: initializations sort, bytecodes sort, remainder sort, privates sort