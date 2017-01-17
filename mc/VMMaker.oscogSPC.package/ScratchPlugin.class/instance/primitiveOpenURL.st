os functions
primitiveOpenURL
	"Open a web browser on the given URL."

	| urlStr src urlOop count |
	<export: true>
	<var: 'urlStr' declareC: 'char urlStr[2000]'>
	<var: 'src' type: #'char *'>

	urlOop := interpreterProxy stackValue: 0.

	interpreterProxy success: (interpreterProxy isBytes: urlOop).

	interpreterProxy failed ifTrue: [^ 0].

	src := self cCoerce: (interpreterProxy firstIndexableField: urlOop) to: #'char *'.
	count := interpreterProxy stSizeOf: urlOop.
	count >= 2000 ifTrue: [interpreterProxy success: false. ^ 0].
	0 to: count - 1 do: [:i | urlStr at: i put: (src at: i)].
	urlStr at: count put: 0.

	self OpenURL: urlStr.

	interpreterProxy pop: 1.  "pop arg, leave rcvr on stack"
	^ 0