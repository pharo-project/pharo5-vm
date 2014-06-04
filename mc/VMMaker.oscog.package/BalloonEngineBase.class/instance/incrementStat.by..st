accessing state
incrementStat: statIndex by: value

	^workBuffer at: statIndex put: (workBuffer at: statIndex) + value