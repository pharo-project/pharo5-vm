C code generation
emitCCommentOn: aStream
	"Emit the transferred Smalltalk comments as C comments."

	comment ifNotNil: [
		aStream cr;cr.
		1 to: comment size do: [:index | | startPos |
			aStream nextPutAll: '/*'; tab.
			startPos := aStream position.
			self printSingleComment: (comment at: index)
				on: aStream
				indent: 1
				tabWidth: 4
				lineBreak: 78.
			aStream position - startPos > (comment at: index) size ifTrue: "probably a multi-line comment"
				[aStream cr].
			aStream nextPutAll: ' */'; cr]]