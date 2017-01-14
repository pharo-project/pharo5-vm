debug printing
warnMultiple: cogMethod selectors: aSelectorOop
	<inline: true>
	<var: 'cogMethod' type: #'CogMethod *'>
	self cCode:
			[self fp: #stderr
				r: 'Warning, attempt to use method with selector %.*s and selector %.*s\n'
				i: (self cCoerceSimple: (objectMemory numBytesOf: cogMethod selector) to: #int)
				n: (self cCoerceSimple: (objectMemory firstIndexableField: cogMethod selector) to: #'char *')
				t: (objectMemory numBytesOf: aSelectorOop)
				f: (self cCoerceSimple: (objectMemory firstIndexableField: aSelectorOop) to: #'char *')]
		inSmalltalk:
			[self warn: 'Warning, attempt to use method with selector ',
						(coInterpreter stringOf: cogMethod selector),
						' and selector ',
						(coInterpreter stringOf: aSelectorOop)]