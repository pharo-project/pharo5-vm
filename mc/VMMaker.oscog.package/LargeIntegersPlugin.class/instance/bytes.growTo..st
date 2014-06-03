oop util
bytes: aBytesObject growTo: newLen 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	"Does not normalize."
	| newBytes oldLen copyLen |
	self remapOop: aBytesObject in: [newBytes := interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: aBytesObject)
					indexableSize: newLen].
	oldLen := self byteSizeOfBytes: aBytesObject.
	oldLen < newLen
		ifTrue: [copyLen := oldLen]
		ifFalse: [copyLen := newLen].
	self
		cBytesCopyFrom: (interpreterProxy firstIndexableField: aBytesObject)
		to: (interpreterProxy firstIndexableField: newBytes)
		len: copyLen.
	^ newBytes