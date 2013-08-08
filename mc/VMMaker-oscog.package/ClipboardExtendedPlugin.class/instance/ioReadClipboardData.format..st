io
ioReadClipboardData: clipboard format: format
| clipboardAddress formatLength |
self primitive: 'ioReadClipboardData' parameters: #(Oop String).
clipboardAddress := interpreterProxy positive32BitValueOf: clipboard.
formatLength := interpreterProxy slotSizeOf: format cPtrAsOop.
^ self sqPasteboardCopyItemFlavorData: clipboardAddress format: format formatLength: formatLength.
