initializing
setSelector: sel definingClass: class args: argList locals: localList block: aBlockNode primitive: aNumber properties: methodProperties comment: aComment
	"Initialize this method using the given information."

	selector := sel.
	definingClass := class.
	returnType := #sqInt. 	 "assume return type is sqInt for now"
	args := argList asOrderedCollection collect: [:arg | arg key].
	locals := (localList collect: [:arg | arg key]) asSet.
	declarations := Dictionary new.
	primitive := aNumber.
	properties := methodProperties.
	comment := aComment.
	parseTree := aBlockNode asTranslatorNodeIn: self.
	labels := OrderedCollection new.
	complete := false.  "set to true when all possible inlining has been done"
	export := self extractExportDirective.
	static := self extractStaticDirective.
	canAsmLabel := self extractLabelDirective.
	self extractSharedCase.
	isPrimitive := false.  "set to true only if you find a primtive direction."
	suppressingFailureGuards := self extractSuppressFailureGuardDirective.
	self recordDeclarationsIn: nil.
	self extractPrimitiveDirectives.
