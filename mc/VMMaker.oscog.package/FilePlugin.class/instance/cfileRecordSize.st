pharo primitives
cfileRecordSize
	"Return the size of a stdio FILE* handle"
	<option: #PharoVM>
	<static: false>
	^self sizeof: #'FILE*'