initialize-release
initialize
	translationDict := Dictionary new.
	inlineList := Array new.
	constants := Dictionary new: 100.
	variables := Set new: 100.
	variableDeclarations := Dictionary new: 100.
	methods := Dictionary new: 500.
	kernelReturnTypes := self computeKernelReturnTypes.
	macros := Dictionary new.
	self initializeCTranslationDictionary.
	headerFiles := OrderedCollection new.
	globalVariableUsage := Dictionary new.
	useSymbolicConstants := true.
	generateDeadCode := true.
	scopeStack := OrderedCollection new.
	logger := (ProvideAnswerNotification new tag: #logger; signal) ifNil: [Transcript].
	pools := IdentitySet new.
	selectorTranslations := IdentityDictionary new.
	suppressAsmLabels := false.
	previousCommentMarksInlining := false.
	previousCommenter := nil.
	breakSrcInlineSelectors := IdentitySet new.
	breakDestInlineSelectors := IdentitySet new