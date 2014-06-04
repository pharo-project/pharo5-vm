debug support
setBreakSelector: aString
	<api>
	<var: #aString type: #'char *'>
	aString isNil
		ifTrue: [breakSelectorLength := -1. "nil's effective length is zero" breakSelector := nil]
		ifFalse: [breakSelectorLength := self strlen: aString. breakSelector := aString]