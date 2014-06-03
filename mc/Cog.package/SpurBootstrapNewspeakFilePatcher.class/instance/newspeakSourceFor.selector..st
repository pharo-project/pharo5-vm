patching
newspeakSourceFor: method "<CompiledMethod>" selector: selector "<Symbol>"
	| source startIndex nextIndex |
	source := method getSourceFromFile asString allButFirst: method selector size - selector size.
	source first ~= selector first ifTrue:
		[source replaceFrom: 1 to: selector size with: selector startingAt: 1].

	"map comments to Newspeak format..."
	startIndex := 1.
	[(startIndex := source indexOf: $" startingAt: startIndex) > 0] whileTrue:
		[nextIndex := source indexOf: $" startingAt: startIndex + 1.
		 nextIndex < startIndex ifTrue:
			[self error: 'matching close comment not found'].
		 source := source copyReplaceFrom: nextIndex to: nextIndex with: ' *)'.
		 source := source copyReplaceFrom: startIndex to: startIndex with: '(* '.
		 startIndex := nextIndex + 5].

	"map assignments to Newspeak format"
	startIndex := 1.
	[(startIndex := source indexOfSubCollection: ':=' startingAt: startIndex) > 0] whileTrue:
		[nextIndex := startIndex.
		 [(source at: nextIndex - 1) isSeparator] whileTrue:
			[nextIndex := nextIndex - 1].
		 source := source copyReplaceFrom: nextIndex to: startIndex + 1 with: '::'.
		 startIndex := nextIndex + 1].

	"add the horror-show parentheses"
	startIndex := source indexOf: Character cr.
	source := source copyReplaceFrom: startIndex to: startIndex - 1 with: ' = ('.
	source := source, (String with: Character cr with: $) ).
	^source