io
ioCreateClipboard
| clipboardAddress |
self primitive: 'ioCreateClipboard' parameters: #().

clipboardAddress := interpreterProxy positive32BitIntegerFor: self sqCreateClipboard.

^ clipboardAddress.