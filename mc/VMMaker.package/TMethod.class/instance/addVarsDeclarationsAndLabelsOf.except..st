inlining support
addVarsDeclarationsAndLabelsOf: methodToBeInlined except: doNotRename
	"Prepare to inline the body of the given method into the receiver by making the args and locals of the argument to the receiver be locals of the receiver. Record any type declarations for these variables. Record labels. Assumes that the variables have already be renamed to avoid name clashes."

	locals
		addAll: (methodToBeInlined args reject: [ :v | doNotRename includes: v]);
		addAll: (methodToBeInlined locals reject: [ :v | doNotRename includes: v]).
	methodToBeInlined declarations keysAndValuesDo:
		[ :v :decl |
		(doNotRename includes: v) ifFalse:
			[self declarationAt: v put: decl]].

	labels addAll: methodToBeInlined labels