inline cacheing
rewriteCPICCaseAt: followingAddress tag: newTag objRef: newObjRef target: newTarget
	"Rewrite the three values involved in a CPIC case. Used by the initialize & extend CPICs."
	self subclassResponsibility
	