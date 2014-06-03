transformations
replaceChild: aNode with: bNode 
	statements := Array streamContents:
					[:s|
					statements do:
						[:node|
						node == aNode
							ifTrue:
								[bNode isStmtList
									ifTrue: [s nextPutAll: bNode statements]
									ifFalse: [s nextPut: bNode]]
							ifFalse: [s nextPut: node]]]