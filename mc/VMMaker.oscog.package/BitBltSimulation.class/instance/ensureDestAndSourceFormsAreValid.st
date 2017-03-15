setup
ensureDestAndSourceFormsAreValid
	"If a GC has occurred, update destForm and sourceForm from the stack."
	<inline: #always>
	numGCsOnInvocation ~= interpreterProxy statNumGCs ifTrue:
		[self reloadDestAndSourceForms]