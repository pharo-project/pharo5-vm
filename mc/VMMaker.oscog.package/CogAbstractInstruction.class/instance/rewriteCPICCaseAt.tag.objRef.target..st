inline cacheing
rewriteCPICCaseAt: followingAddress tag: newTag objRef: newObjRef target: newTarget
	"rewrite the three values involved in a CPIC case. Used by the create & extend cpcic methods"
	self subclassResponsibility
	