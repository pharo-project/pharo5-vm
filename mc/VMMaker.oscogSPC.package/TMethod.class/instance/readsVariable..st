accessing
readsVariable: variableName
	"Answer if the receiver reads the variable (i.e. ignore assignments to the variable)."
	parseTree nodesWithParentsDo:
		[:node :parent|
		 (node isVariable
		  and: [node name = variableName]) ifTrue:
			[(parent notNil
			  and: [parent isAssignment
			  and: [node == parent variable]]) ifFalse:
				[^true]]].
	^false