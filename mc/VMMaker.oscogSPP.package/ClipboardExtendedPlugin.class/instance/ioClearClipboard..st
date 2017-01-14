io
ioClearClipboard: clipboard
	| clipboardAddress |
	<var: #clipboardAddress type: #'usqIntptr_t'>
	self primitive: 'ioClearClipboard' parameters: #(Oop).
	clipboardAddress :=  interpreterProxy positiveMachineIntegerValueOf: clipboard.
	self sqPasteboardClear: clipboardAddress.