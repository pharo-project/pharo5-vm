initialization
trampolineName: routinePrefix numArgs: numArgs limit: argsLimit
	"Malloc a string with the contents for the trampoline table"
	<inline: true>
	<returnTypeC: #'char *'>
	<var: #routinePrefix type: #'char *'>
	<var: #numArgs type: #int>
	| theString |
	<var: #theString type: #'char *'>
	self cCode: '' inSmalltalk:
		[^routinePrefix, (numArgs <= argsLimit ifTrue: [numArgs printString] ifFalse: ['N']), 'Args'].
	theString := self malloc: (self strlen: routinePrefix) + 6.
	self s: theString pr: '%s%cArgs' in: routinePrefix tf: (numArgs <= argsLimit ifTrue: [$0 + numArgs] ifFalse: [$N]).
	^theString