simulation only
cCoerce: value to: cTypeString
	"Type coercion for translation only; just return the value when running in Smalltalk."
	<doNotGenerate>
	^value == nil
		ifTrue: [value]
		ifFalse: [value coerceTo: cTypeString sim: objectMemory]