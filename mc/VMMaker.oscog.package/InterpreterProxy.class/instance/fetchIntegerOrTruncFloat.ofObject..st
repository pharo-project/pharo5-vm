private
fetchIntegerOrTruncFloat: fieldIndex ofObject: objectPointer
	"Support for BitBlt simulation only"
	| intOrFloat |
	intOrFloat := self fetchPointer: fieldIndex ofObject: objectPointer.
	(self isIntegerObject: intOrFloat) ifTrue: [^ self integerValueOf: intOrFloat].
	intOrFloat isFloat ifTrue:[^intOrFloat truncated].
	^self primitiveFail.