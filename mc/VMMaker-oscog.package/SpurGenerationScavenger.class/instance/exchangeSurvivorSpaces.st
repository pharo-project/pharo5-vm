scavenger
exchangeSurvivorSpaces
	| temp |
	temp := pastSpace.
	pastSpace := futureSpace.
	futureSpace := temp