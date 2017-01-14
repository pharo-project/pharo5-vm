inline cacheing
relocateMethodReferenceBeforeAddress: pc by: delta
	"On some processors the method reference is a load constant and
	 hence needs changing when methods are moved.  On others the
	 method reference is pc-relative and hence nothing needs to happen."
	self subclassResponsibility