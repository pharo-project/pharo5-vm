debug support
setBreakMNUSelector: aString
	<api>
	<var: #aString type: #'char *'>
	(breakSelector := aString)
		ifNil: [breakSelectorLength := objectMemory minSmallInteger "nil's effective length is zero"]
		ifNotNil: [breakSelectorLength := (self strlen: aString) negated]