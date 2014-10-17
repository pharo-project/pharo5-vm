accessing
run
   [ self tokenNotDone ] whileTrue: [ nextThread takeToken: token - 1 ].
   output print: name.
   output name = 'stdout'
	ifTrue: [output nl]
	ifFalse: [output cr; flush].
   done signal 