debug support
checkOopIntegrity: obj named: name
	<inline: false>
	<var: #name type: #'char *'>
	(self heapMapAtWord: (self pointerForOop: obj)) ~= 0 ifTrue:
		[^true].
	self print: name; print: ' leak '; printHex: obj; cr.
	^false