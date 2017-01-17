initialization
setSelector: sel definingClass: class args: argList locals: localList block: aBlockNode primitive: aNumber properties: methodProperties comment: aComment
	"Initialize this method using the given information."

	selector := sel.
	definingClass := class.
	args := argList asOrderedCollection collect: [:arg | arg key].
	locals := (localList collect: [:arg | arg key]) asSet.
	declarations := Dictionary new.
	self addTypeForSelf.
	primitive := aNumber.
	properties := methodProperties.
	comment := aComment.
	labels := Set new.
	parseTree := aBlockNode. "hack; allows nodes to find their parent, etc"
	parseTree := aBlockNode asTranslatorNodeIn: self.
	complete := false.  "set to true when all possible inlining has been done"
	export := self extractExportDirective.
	static := self extractStaticDirective.
	self extractSharedCase.
	globalStructureBuildMethodHasFoo := false