convert sends to pragmas
newPragmatizedSourceFrom: source nodes: pragmaNodes nodeRanges: ranges

	^ String streamContents: [:str|
		str nextPutAll: (source copyFrom: 1 to: ranges first - 6).
		pragmaNodes
			do: [:node| | pragma args |
				str nextPut: $<.
				str nextPutAll: (node asString allButFirst: 6) allButLast.
				str nextPut: $>]
			separatedBy: [str crtab: 1].
		str nextPutAll: (source copyFrom: ((ranges last + 1 <= source size
										   and: [(source at: ranges last + 1) = $.])
											ifTrue: [ranges last + 2]
											ifFalse: [ranges last + 1])
							to: source size)]
