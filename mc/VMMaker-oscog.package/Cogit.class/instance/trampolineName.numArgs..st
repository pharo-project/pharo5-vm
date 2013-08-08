initialization
trampolineName: routinePrefix numArgs: numArgs
	"Malloc a string with the contents for the trampoline table"
	<returnTypeC: #'char *'>
	<var: #routinePrefix type: #'char *'>
	| theString |
	<var: #theString type: #'char *'>
	self cCode: '' inSmalltalk:
		[^routinePrefix, (numArgs >= 0 ifTrue: [numArgs printString] ifFalse: ['N']), 'Args'].
	theString := self malloc: (self strlen: routinePrefix) + 6.
	self s: theString pr: '%s%cArgs' in: routinePrefix tf: (numArgs >= 0 ifTrue: [$0 + numArgs] ifFalse: [$N]).
	^theString