initialize-release
initialize
	xlator := [:s| s copyReplaceAll: 'print' with: 'printWithClosureAnalysis'].
	xlation := Dictionary new.
	(((ParseNode withAllSubclasses removeAll: Encoder withAllSubclasses; yourself)
		inject: Set new
		into: [:s :c| s addAll: c selectors. s]) select:
			[:s| s beginsWith: 'print']) do:
				[:s|xlation at: s put: (xlator value: s) asSymbol].
	kwdxlation := Dictionary new.
	xlation keysAndValuesDo: [:k :v| kwdxlation at: k keywords first put: v keywords first]