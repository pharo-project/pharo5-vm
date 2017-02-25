primitives
primitiveMPEG3Open: path
	| mpeg3Oop index sz storage |

	"mpeg3_t* mpeg3_open(char *path)"
	<var: #index declareC: 'mpeg3_t ** index'>
	<var: #storage declareC: 'char storage[1024]'>
	self primitive: 'primitiveMPEG3Open'
		parameters: #(String).
	sz := interpreterProxy byteSizeOf: path cPtrAsOop.
	interpreterProxy ioFilename: storage fromString: path ofLength: sz resolveAliases: true.
	mpeg3Oop := interpreterProxy instantiateClass: interpreterProxy classByteArray
					indexableSize: 4.
	index := self cCoerce: (interpreterProxy firstIndexableField: mpeg3Oop)
						to: 'mpeg3_t **'.
	self cCode: '*index = mpeg3_open(storage,0); makeFileEntry(*index)'.
	^mpeg3Oop.
