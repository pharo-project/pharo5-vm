io
ioClearClipboard: clipboard
	| clipboardAddress |
	<var: #clipboardAddress type: #'unsigned long'>
	self primitive: 'ioClearClipboard' parameters: #(Oop).
	clipboardAddress :=  interpreterProxy positiveMachineIntegerValueOf: clipboard.
	self sqPasteboardClear: clipboardAddress.