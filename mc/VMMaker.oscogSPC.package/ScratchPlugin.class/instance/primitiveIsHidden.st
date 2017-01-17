os functions
primitiveIsHidden
	"Answer true if the file or folder with the given path should be hidden from the user. On Windows, this is the value of the 'hidden' file property."

	| pathOop src count fullPath result |
	<export: true>
	<var: 'fullPath' declareC: 'char fullPath[1000]'>
	<var: 'src' type: #'char *'>

	pathOop := interpreterProxy stackValue: 0.

	interpreterProxy success: (interpreterProxy isBytes: pathOop).

	interpreterProxy failed ifTrue: [^ 0].

	src := self cCoerce: (interpreterProxy firstIndexableField: pathOop) to: #'char *'.
	count := interpreterProxy stSizeOf: pathOop.
	count >= 1000 ifTrue: [interpreterProxy success: false. ^ 0].
	0 to: count - 1 do: [:i | fullPath at: i put: (src at: i)].
	fullPath at: count put: 0.

	result := self IsFileOrFolderHidden: fullPath.

	interpreterProxy pop: 2.  "pop arg and rcvr"
	interpreterProxy pushBool: result ~= 0.  "push result"
	^ 0