C code generation
emitCCommentOn: aStream level: level generator: aCodeGen
	"Emit the transferred Smalltalk comments as C comments."

	((aCodeGen previousCommenter: self) == self or: [comment isNil]) ifTrue:
		[aCodeGen previousCommentMarksInlining: false.
		 ^self].
	comment withIndexDo:
		[:commentString :index |
		(index = 1 and: [commentString beginsWith: 'begin ']) ifTrue:
			[(aCodeGen previousCommentMarksInlining: true) ifTrue: [^true]].
		aStream crtab: level; nextPutAll: '/* '.
		((comment at: index) findTokens: Character cr)
			do: [:line| aStream nextPutAll: line withBlanksTrimmed]
			separatedBy: [aStream crtab: level; next: 3 put: Character space].
		aStream nextPutAll: ' */'].
	 aStream cr