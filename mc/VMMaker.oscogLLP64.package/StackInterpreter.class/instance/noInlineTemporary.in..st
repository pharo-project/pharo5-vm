internal interpreter access
noInlineTemporary: offset in: theFP
	<var: #theFP type: #'char *'>
	<inline: false>
	^self temporary: offset in: theFP