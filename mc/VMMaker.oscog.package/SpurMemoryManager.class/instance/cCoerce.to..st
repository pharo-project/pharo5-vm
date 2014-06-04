memory access
cCoerce: value to: cTypeString
	"Type coercion. For translation a cast will be emmitted. When running in Smalltalk
	  answer a suitable wrapper for correct indexing."

	^value
		ifNil: [value]
		ifNotNil: [value coerceTo: cTypeString sim: self]