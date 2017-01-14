accessing
setVariable: varNode expression: expressionNode
	self assert: (expressionNode isGoTo or: [expressionNode isLabel]) not.
	variable := varNode.
	expression := expressionNode.