printing
printCogMethods
	<api>
	<returnTypeC: #void>
	| cogMethod nm nc no nf nu |
	<var: #cogMethod type: #'CogMethod *'>
	nm := nc := no := nf := nu := 0.
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[coInterpreter printCogMethod: cogMethod.
		 cogMethod cmType
			caseOf: {
			[CMFree]		->	[nf := nf + 1].
			[CMMethod]	->	[nm := nm + 1].
			[CMClosedPIC]	->	[nc := nc + 1].
			[CMOpenPIC]	->	[no:= no+ 1] }
			otherwise: [nu := nu + 1].
		 cogMethod := self methodAfter: cogMethod].
	coInterpreter print: 'CMMethod '; printNum: nm;  print: ' CMClosedPIC '; printNum: nc;  print: ' CMOpenPIC '; printNum: no;  print: ' CMFree '; printNum: nf.
	nu > 0 ifTrue:
		[coInterpreter print: ' UNKNOWN '; printNum: nu].
	coInterpreter print: ' total '; printNum: nm+nc+no+nf+nu; cr