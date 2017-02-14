inlining
isFunctionalIn: aCodeGen
	"Answer if the receiver is a functional method. That is, if it
	 consists of a single return statement of an expression that
	 contains no other returns, or an assert or flag followed by
	 such a statement.

	 Answer false for methods with return types other than the simple
	 integer types to work around bugs in the inliner."

	parseTree statements size = 1 ifFalse:
		[(parseTree statements size = 2
		  and: [parseTree statements first isSend
		  and: [parseTree statements first selector == #flag:
			or: [(aCodeGen isAssertSelector: parseTree statements first selector)
				and: [parseTree statements first selector ~~ #asserta:]]]]) ifFalse:
			[^false]].
	parseTree statements last isReturn ifFalse:
		[^false].
	parseTree statements last expression nodesDo:
		[ :n | n isReturn ifTrue: [^false]].
	^#(int #'unsigned int' #long #'unsigned long' #'long long' #'unsigned long long'
		sqInt usqInt #'sqIntptr_t' #'usqIntptr_t' sqLong usqLong
		#'int *' #'unsigned int *' #'sqInt *' #'usqInt *' #'sqLong *' #'usqLong *' #'char *'
		#'CogMethod *' #'AbstractInstruction *') includes: returnType