os functions
primitiveShortToLongPath
	"On Windows, convert a short file/path name into a long one. Fail on other platforms."

	| shortPath longPath ptr shortPathOop result count resultOop |
	<export: true>
	<var: 'shortPath' declareC: 'char shortPath[1000]'>
	<var: 'longPath' declareC: 'char longPath[1000]'>
	<var: 'ptr' type: #'char *'>

	shortPathOop := interpreterProxy stackValue: 0.

	(interpreterProxy isBytes: shortPathOop) ifFalse:
		[interpreterProxy success: false. ^ 0].

	ptr := self cCoerce: (interpreterProxy firstIndexableField: shortPathOop) to: #'char *'.
	count := interpreterProxy stSizeOf: shortPathOop.
	count >= 1000 ifTrue: [interpreterProxy success: false. ^ 0].
	0 to: count - 1 do: [:i | shortPath at: i put: (ptr at: i)].
	shortPath at: count put: 0.

	result := self cCode: 'WinShortToLongPath(shortPath, longPath, 1000)'.
	result = -1 ifTrue: [interpreterProxy success: false. ^ 0].

	count := self strlen: longPath.
	resultOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: count.
	ptr := self cCoerce: (interpreterProxy firstIndexableField: resultOop) to: #'char *'.
	0 to: count - 1 do: [:i | ptr at: i put: (longPath at: i)].

	interpreterProxy pop: 2 thenPush: resultOop.  "pop arg and rcvr, push result"
	^ 0