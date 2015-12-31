encoding
low16BitsOf: word
	<var: #word type: #usqInt>
	^word bitAnd: 16rFFFF