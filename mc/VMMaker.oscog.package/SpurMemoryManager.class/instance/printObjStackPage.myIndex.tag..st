obj stacks
printObjStackPage: objStackPage myIndex: myx tag: pageType
	<var: 'pageType' type: #'char *'>
	<inline: false>
	coInterpreter
		print: pageType; space; printHex: objStackPage; space;
		print: 'cx '; printNum: (self classIndexOf: objStackPage);
		print: ' ('; printNum: self wordSizeClassIndexPun;
		print: ') fmt '; printNum: (self formatOf: objStackPage);
		print: ' ('; printNum: self wordIndexableFormat;
		print: ') sz '; printNum: (self numSlotsOfAny: objStackPage);
		print: ' ('; printNum: ObjStackPageSlots;
		print: ') myx: '; printNum: (self fetchPointer: ObjStackMyx ofObject: objStackPage);
		print: ' ('; printNum: myx;
		print: ((self isMarked: objStackPage) ifTrue: [') mkd'] ifFalse: [') unmkd']);
		cr