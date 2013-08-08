code editing
edit: generateViewBar
	"self new edit: true"
	| sn |
	sn := SystemNavigation default.
	xlation keysAndValuesDo:
		[:s :t|
		(sn allImplementorsOf: s localTo: ParseNode) do:
			[:md| | newCode |
			newCode := self editCode: md sourceString inClass: md actualClass withSelector: md methodSymbol.
			generateViewBar
				ifTrue: [md actualClass compile: newCode classified: 'printing']
				ifFalse:
					[(StringHolder new textContents:
						(CodeDiffBuilder buildDisplayPatchFrom: md sourceString to: newCode))
							openLabel: md printString]]]