os functions
primitiveSetWindowTitle
	"Set the title of the Scratch window."

	| titleStr src titleOop count |
	<export: true>
	<var: 'titleStr' declareC: 'char titleStr[1000]'>
	<var: 'src' type: #'char *'>

	titleOop := interpreterProxy stackValue: 0.

	interpreterProxy success: (interpreterProxy isBytes: titleOop).

	interpreterProxy failed ifTrue: [^ 0].

	src := self cCoerce: (interpreterProxy firstIndexableField: titleOop) to: #'char *'.
	count := interpreterProxy stSizeOf: titleOop.
	count >= 1000 ifTrue: [interpreterProxy success: false. ^ 0].
	0 to: count - 1 do: [:i | titleStr at: i put: (src at: i)].
	titleStr at: count put: 0.

	self SetScratchWindowTitle: titleStr.

	interpreterProxy pop: 1.  "pop arg, leave rcvr on stack"
	^ 0