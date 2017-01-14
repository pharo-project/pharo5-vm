utilities
nodeIsDeadCode: aNode withParent: parentNode
	"Answer if aNode would not be generated due to dead code elimination."
	^(self nilOrBooleanConditionFor: parentNode)
		ifNil: [false]
		ifNotNil:
			[:cond| | filter |
			filter := parentNode selector caseOf:
							{   "First element is accessor for filtered (eliminated) node if expression is true.
								Second element is accessor for filtered (eliminated) node if expression is false."
								[#ifFalse:]				-> [#(first nil)].
								[#ifFalse:ifTrue:] 		-> [#(first last)].
								[#ifTrue:]				-> [#(nil first)].
								[#ifTrue:ifFalse:]			-> [#(last first)].
								[#and:]					-> [#(nil first)].
								[#or:]					-> [#(last nil)].
								[#cppIf:ifTrue:]			-> [#(nil #second)].
								[#cppIf:ifTrue:ifFalse:]	-> [#(third #second)] }.
			(cond ifTrue: [filter first] ifFalse: [filter last])
				ifNil: [false]
				ifNotNil: [:accessor| aNode == (parentNode args perform: accessor)]]