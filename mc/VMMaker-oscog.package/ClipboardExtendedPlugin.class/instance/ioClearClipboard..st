io
ioClearClipboard: clipboard
| clipboardAddress |
self primitive: 'ioClearClipboard' parameters: #(Oop).
clipboardAddress :=  interpreterProxy positive32BitValueOf: clipboard.
self sqPasteboardClear: clipboardAddress.