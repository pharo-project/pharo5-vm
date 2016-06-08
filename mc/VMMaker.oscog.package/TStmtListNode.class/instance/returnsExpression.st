testing
returnsExpression
	"Answer true if the last statement of this block is a return of some expression, not merely self or nil."

	statements isEmpty ifTrue:
		[^false].
	statements last isReturn ifFalse:
		[^false].
	statements last isVariable ifFalse:
		[^true].
	^statements last variable ~= 'self'
	  and: [statements last variable ~= 'nil']