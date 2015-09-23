generation scavenging
scavengingGCTenuringIf: tenuringCriterion
	"Run the scavenger."
	"self halt: (statScavenges + 1) printString, ((statScavenges between: 9 and: 19)
													ifTrue: ['th']
													ifFalse: [#('st' 'nd' 'rd') at: (statScavenges + 1) \\ 10 ifAbsent: 'th']), ' scavenge'."
	^super scavengingGCTenuringIf: tenuringCriterion