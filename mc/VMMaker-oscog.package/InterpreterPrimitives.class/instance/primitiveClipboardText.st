I/O primitives deprecated
primitiveClipboardText
	"When called with a single string argument, post the string to 
	the clipboard. When called with zero arguments, return a 
	string containing the current clipboard contents."
	self primitiveFailFor: PrimErrUnsupported.