os functions
primitiveGetFolderPath
	"Get the path for the special folder with given ID. Fail if the folder ID is out of range."

	| nameStr dst folderID count resultOop |
	<export: true>
	<var: 'nameStr' declareC: 'char nameStr[2000]'>
	<var: 'dst' declareC: 'char* dst'>

	folderID := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	self cCode: 'GetFolderPathForID(folderID, nameStr, 2000)'.

	count := self cCode: 'strlen(nameStr)'.
	resultOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: count.
	dst := self cCoerce: (interpreterProxy firstIndexableField: resultOop) to: 'char *'.
	0 to: count - 1 do: [:i | dst at: i put: (nameStr at: i)].

	interpreterProxy pop: 2 thenPush: resultOop.  "pop arg and rcvr, push result"
	^ 0
