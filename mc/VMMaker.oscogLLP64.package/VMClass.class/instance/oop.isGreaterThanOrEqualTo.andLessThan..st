oop comparison
oop: anOop isGreaterThanOrEqualTo: baseOop andLessThan: limitOop
	"Compare two oop values, treating them as object memory locations; i.e. use unsigned comparisons.
	 Use a macro, instead of #cCoerce:to: to provide fast simulation and inline code in conditionals,
	 since the inliner doesn't inline in condtionals."
	<cmacro: '(anOop,baseOop,limitOop) ((usqInt)(anOop) >= (usqInt)(baseOop) && (usqInt)(anOop) < (usqInt)(limitOop))'>
	^anOop >= baseOop and: [anOop < limitOop]