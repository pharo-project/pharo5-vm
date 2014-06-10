primitives
primitiveMPEG3CheckSig: path
	| result sz storage |

	"int mpeg3_check_sig(char *path)"
	<var: #storage declareC: 'char storage[1024] '>
	self primitive: 'primitiveMPEG3CheckSig'
		parameters: #(String).
	sz := interpreterProxy byteSizeOf: path cPtrAsOop.
	interpreterProxy ioFilename: storage fromString: path ofLength: sz resolveAliases: true.
	self cCode: 'result = mpeg3_check_sig(storage)'.
	^result asOop: Boolean
