C library extensions
stretch: s1 cat: s2
	<var: 's1' type: #'char *'>
	<var: 's2' type: #'char *'>
	| ns |
	<var: 'ns' type: #'char *'>
	^self
		cCode:
			[ns := self malloc: (self strlen: s1) + (self strlen: s2) + 2.
			self str: ns cpy: s1.
			self str: ns cat: s2]
		inSmalltalk: [self str: s1 cat: s2]