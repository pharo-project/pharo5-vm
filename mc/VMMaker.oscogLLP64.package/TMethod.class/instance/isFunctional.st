inlining
isFunctional
	"Answer true if the receiver is a functional method. That is, if it
	 consists of a single return statement of an expression that contains
	 no other returns.

	 Answer false for methods with return types other than the simple
	 integer types to work around bugs in the inliner."

	parseTree statements isEmpty ifTrue:
		[^false].
	parseTree statements last isReturn ifFalse:
		[^false].
	parseTree statements size = 1 ifFalse:
		[(parseTree statements size = 2
		  and: [parseTree statements first isSend
		  and: [parseTree statements first selector == #flag:]]) ifFalse:
			[^false]].
	parseTree statements last expression nodesDo:
		[ :n | n isReturn ifTrue: [^false]].
	^#(int #'unsigned int' #'long long' #'unsigned long long'
		sqInt usqInt #'sqIntptr_t' #'usqIntptr_t' sqLong usqLong
		#'int *' #'unsigned int *' #'sqInt *' #'usqInt *' #'sqLong *' #'usqLong *' #'CogMethod *' #'char *') includes: returnType