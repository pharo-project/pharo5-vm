convert sends to pragmas
pragmatize: methodReference
	"Pragmatize the method. Answer true if the method was not modified, and false
	if conversion was performed."

	| method methodNode pragmaNodes sourceRanges ranges source newSource stamp newStamp |
	method := methodReference compiledMethod.
	methodNode := method methodNode.
	pragmaNodes := SortedCollection
						sortBlock: [:a :b | (sourceRanges at: a) first <= (sourceRanges at: b) first].
	(sourceRanges := methodNode rawSourceRanges)
		keysAndValuesDo: [:node :range | (node isMessageNode
					and: [selectors includes: node selector key])
				ifTrue: [pragmaNodes add: node]].
	^ pragmaNodes isEmpty
		ifFalse: [ranges := (sourceRanges at: pragmaNodes first) first
								to: (sourceRanges at: pragmaNodes last) last.

				source := method getSourceFromFile asString.
				"methodBodyStart := method methodClass parserClass new
										parseMethodComment: source setPattern: [:ignored|];
										startOfNextToken.
				tempsStart := source indexOf: $| startingAt: methodBodyStart.
				hasTemps := tempsStart > 0 and: [tempsStart < ranges first]."
				(source copyFrom: ranges first - 5 to: ranges first - 1) ~= 'self ' ifTrue: [self halt].
				(ranges last < source size
					and: [(source indexOf: $. startingAt: ranges last) > (ranges last + 1)]) ifTrue: [self halt].
				newSource := self newPragmatizedSourceFrom: source
							nodes: pragmaNodes
							nodeRanges: ranges.
				stamp := method timeStamp.
				newStamp := self newConvertToPragmaStamp: stamp.
				Transcript
					print: method methodClass;
					nextPutAll: '>>';
					print: method selector;
					nextPut: Character space;
					nextPutAll: newStamp;
					cr; flush.
				method methodClass
					compile: newSource
					classified: methodReference category
					withStamp: newStamp
					notifying: nil.
				false]
