private - file handles
stdinHandle

	| h |
	<returnTypeC: 'HANDLE'>
	<var: 'h' type: 'HANDLE'>
	h := self cCode: 'GetStdHandle(STD_INPUT_HANDLE)' inSmalltalk: [0].
	(self cCode: 'h == INVALID_HANDLE_VALUE' inSmalltalk: [-1])
		ifTrue: [interpreterProxy primitiveFail].
	^ h
