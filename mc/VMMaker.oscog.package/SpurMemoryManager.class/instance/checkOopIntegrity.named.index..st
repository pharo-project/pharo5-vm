debug support
checkOopIntegrity: obj named: name index: i
	<inline: false>
	<var: #name type: #'char *'>
	(heapMap heapMapAtWord: (self pointerForOop: obj)) ~= 0 ifTrue:
		[^true].
	coInterpreter print: name; print: ' leak @ '; printNum: i; print: ' = '; printHex: obj; cr.
	^false