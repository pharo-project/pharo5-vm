C translation
generateToByDoLimitExpression: limitExpr negative: negative on: aStream
	"Generate the limit expression for a to:do: or to:by:do:.
	 If the limitExpr is of the form foo - 1 use < foo or > foo, as appropriate, instead of
	 <= (foo - 1) or >= (foo - 1), so as to avoid underflowing an unsigned value to maxint."
	(limitExpr isSend
	 and: [limitExpr selector = #-
	 and: [limitExpr args first isConstant
	 and: [limitExpr args first value = 1]]])
		ifTrue:
			[aStream nextPutAll: (negative ifTrue: [' > '] ifFalse: [' < ']).
			 self emitCExpression: limitExpr receiver on: aStream]
		ifFalse:
			[aStream nextPutAll: (negative ifTrue: [' >= '] ifFalse: [' <= ']).
			 self emitCExpression: limitExpr on: aStream]