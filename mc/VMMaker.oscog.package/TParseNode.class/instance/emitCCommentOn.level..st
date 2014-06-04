C code generation
emitCCommentOn: aStream level: level
	"Emit the transferred Smalltalk comments as C comments."

	comment ifNotNil:
		[comment isString ifTrue: [^self].	"safety catch"
		 aStream cr.
		 1 to: comment size do: [:index | 
			aStream tab: level; nextPutAll: '/* '.
			((comment at: index) findTokens: Character cr)
				do: [:line| aStream nextPutAll: line withBlanksTrimmed]
				separatedBy: [aStream crtab: level; next: 3 put: Character space].
			aStream nextPutAll: ' */'; cr].
		 aStream cr]