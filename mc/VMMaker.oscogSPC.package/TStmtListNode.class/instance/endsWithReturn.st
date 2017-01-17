testing
endsWithReturn
	"Answer true if the last statement of this lock is a return."

	^statements notEmpty
	  and: [statements last isReturn or: [statements last isReturningIf]]