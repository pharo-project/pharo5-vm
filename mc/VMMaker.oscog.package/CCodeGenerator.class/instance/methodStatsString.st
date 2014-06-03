inlining
methodStatsString
	"Return a string describing the size, # of locals, and # of senders of
	 each method. Note methods that have inline C code or C declarations."

	| methodsWithCCode sizesOf callsOf s |
	methodsWithCCode := Set new: methods size.
	sizesOf := Dictionary new: methods size * 2.  "selector -> nodeCount"
	callsOf := Dictionary new: methods size * 2.  "selector -> senderCount"

	"For each method, scan its parse tree once to:
		1. determine if the method contains C code or declarations
		2. determine how many nodes it has
		3. increment the sender counts of the methods it calls
		4. determine if it includes any C declarations or code"

	methods do: [ :m | | hasCCode nodeCount |
		(translationDict includesKey: m selector) ifTrue: [
			hasCCode := true.
		] ifFalse: [
			hasCCode := m declarations size > 0.
			nodeCount := 0.
			m parseTree nodesDo: [ :node | | selr senderCount |
				node isSend ifTrue: [
					selr := node selector.
					node isNonNullCCode ifTrue: [ hasCCode := true ].
					senderCount := callsOf at: selr ifAbsent: [ 0 ].
					callsOf at: selr put: senderCount + 1.
				].
				nodeCount := nodeCount + 1.
			].
		].
		hasCCode ifTrue: [ methodsWithCCode add: m selector ].
		sizesOf at: m selector put: nodeCount.
	].

	s := WriteStream on: (String new: 5000).
	(self sortStrings: methods keys) do: [ :sel | | m calls registers |
		m := methods at: sel.
		registers := m locals size + m args size.
		calls := callsOf at: sel ifAbsent: [0].
		registers > 11 ifTrue: [
			s nextPutAll: sel; tab.
			s nextPutAll: (sizesOf at: sel) printString; tab.
			s nextPutAll: calls printString; tab.
			s nextPutAll: registers printString; tab.
			(methodsWithCCode includes: sel) ifTrue: [ s nextPutAll: 'CCode' ].
		s cr.
		].
	].
	^ s contents