primitives
primitiveClipboardPut
	"Set the clipboard to a UTF16 string.."

	| strOop count utf16 utf16Length |
	<export: true>
	<var: 'utf16' type: #'unsigned short *'>

	strOop := interpreterProxy stackValue: 1.
	count := interpreterProxy stackIntegerValue: 0.

	interpreterProxy success: (interpreterProxy isWords: strOop).

	interpreterProxy failed ifTrue: [^ 0].

	utf16 := self cCoerce: (interpreterProxy firstIndexableField: strOop) to: #'unsigned short *'.
	utf16Length := 2 * (interpreterProxy stSizeOf: strOop).
	((count >= 0) & (count < utf16Length)) ifTrue: [utf16Length := count].

	self unicodeClipboard: utf16 Put: utf16Length.

	interpreterProxy pop: 2.  "pop args, leave rcvr on stack"
	^ 0