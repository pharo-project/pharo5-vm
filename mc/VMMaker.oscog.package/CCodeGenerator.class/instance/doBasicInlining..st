inlining
doBasicInlining: inlineFlagOrSymbol
	"Inline the bodies of all methods that are suitable for inlining.
	This method does only the basic inlining suitable for both the core VM and plugins - no bytecode inlining etc"

	| pass progress |
	self collectInlineList: inlineFlagOrSymbol.
	pass := 0.
	progress := true.
	[progress] whileTrue: [
		"repeatedly attempt to inline methods until no further progress is made"
		progress := false.
		('Inlining pass ', (pass := pass + 1) printString, '...')
			displayProgressAt: Sensor cursorPoint
			from: 0 to: methods size
			during: [:bar |
				(self sortMethods: methods) doWithIndex: [:m :i |
					bar value: i.
					currentMethod := m.
					(m tryToInlineMethodsIn: self)
						ifTrue: [progress := true]]]].

