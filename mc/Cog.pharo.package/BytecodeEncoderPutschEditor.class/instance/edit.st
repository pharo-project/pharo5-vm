code editing
edit
	| sn |
	sn := SystemNavigation default.
	xlation keysAndValuesDo:
		[:s :t|
		(sn allImplementorsOf: s localTo: ParseNode) do:
			[:md|
			md actualClass
				compile: (self editCode: md sourceString inClass: md actualClass withSelector: md methodSymbol)
				classified: 'code generation (new scheme)']]