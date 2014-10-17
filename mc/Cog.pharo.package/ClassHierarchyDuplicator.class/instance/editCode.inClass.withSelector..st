code editing
editCode: sourceText inClass: class withSelector: selector
	| ranges index codeIndex output codeString range |
	ranges := SHParserST80 new
				rangesIn: (codeString := sourceText asString)
				classOrMetaClass: class
				workspace: nil
				environment: nil.
	index := codeIndex := 1.
	output := (String new: codeString size) writeStream.
	[index <= ranges size] whileTrue:
		[range := ranges at: index.
		 index := index + 1.
		 [codeIndex < range start] whileTrue:
			[output nextPut: (codeString at: codeIndex).
			 codeIndex := codeIndex + 1].
		range type == #assignment
			ifTrue: [output nextPutAll: ':='.
					codeIndex := range end + 1]
			ifFalse:
				[(#(globalVar classVar) includes: range type)
					ifTrue:
						[output nextPutAll: (xlator value: (codeString copyFrom: range start to: range end)).
						 codeIndex := range end + 1]
					ifFalse:
						[#symbol == range type
							ifTrue:
								[output
									nextPut: (codeString at: range start); "#"
									nextPutAll: (xlator value: (codeString copyFrom: range start + 1 to: range end)).
								 codeIndex := range end + 1]
							ifFalse:
								[[codeIndex <= range end] whileTrue:
									[output nextPut: (codeString at: codeIndex).
									 codeIndex := codeIndex + 1].
								"kill whitespace after up-arrow in ^ expr"
								(range type == #return and: [index <= ranges size]) ifTrue:
									[codeIndex := (ranges at: index) start]]]]].
	^output contents

	"SHParserST80 new
		rangesIn: (ClassHierarchyDuplicator sourceCodeAt: #editCode:inClass:withSelector:) asString
		classOrMetaClass: ClassHierarchyDuplicator
		workspace: nil
		environment: nil"

	"SHParserST80 new
		rangesIn: ClassHierarchyDuplicator definition asString
		classOrMetaClass: nil
		workspace: nil
		environment: nil"

	"ClassHierarchyDuplicator new editCode: LeafNode definition inClass: nil withSelector: nil"
	"ClassHierarchyDuplicator new editCode: (MessageNode sourceCodeAt: #emitToDo:on:value:) inClass: MethodNode withSelector: #emitToDo:on:value:"
	"ClassHierarchyDuplicator new editCode: (MessageNode class sourceCodeAt: #initialize) inClass: MessageNode class withSelector: #initialize"