internal interpreter access
temporary: offset in: theFP
	"See StackInterpreter class>>initializeFrameIndices"
	| frameNumArgs |
	<inline: true>
	<var: #theFP type: #'char *'>
	^offset < (frameNumArgs := self frameNumArgs: theFP)
		ifTrue: [stackPages longAt: theFP + FoxCallerSavedIP + ((frameNumArgs - offset) * objectMemory wordSize)]
		ifFalse: [stackPages longAt: theFP + FoxReceiver - objectMemory wordSize + ((frameNumArgs - offset) * objectMemory wordSize)]