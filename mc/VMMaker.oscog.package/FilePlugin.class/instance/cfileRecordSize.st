file primitives
cfileRecordSize
	"Return the size of a stdio FILE* handle"
	<static: false>
	^self sizeof: #'FILE*'