internal interpreter access
noInlineTemporary: offset in: theFP put: valueOop
	<var: #theFP type: #'char *'>
	<inline: false>
	^self temporary: offset in: theFP put: valueOop