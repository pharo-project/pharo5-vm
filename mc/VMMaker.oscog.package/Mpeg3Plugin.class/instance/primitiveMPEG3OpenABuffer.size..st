primitives
primitiveMPEG3OpenABuffer: path size: size
	| mpeg3Oop index |

	<var: #index declareC: 'mpeg3_t ** index'>
	self primitive: 'primitiveMPEG3OpenABuffer'
		parameters: #(String SmallInteger).
	mpeg3Oop := interpreterProxy instantiateClass: interpreterProxy classByteArray
					indexableSize: 4.	
	index := self cCoerce: (interpreterProxy firstIndexableField: mpeg3Oop)
						to: 'mpeg3_t **'.
	self cCode: '*index = mpeg3_open(path,size); makeFileEntry(*index)'.
	^mpeg3Oop.
