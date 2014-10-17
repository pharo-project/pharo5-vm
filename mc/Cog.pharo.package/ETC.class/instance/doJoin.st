private
doJoin
	scanner pc < blockEnd ifTrue:
		[currentContext instVarNamed: 'stackp' put: (joinOffsets at: scanner pc)]