scavenger
exchangeSurvivorSpaces
	| temp |
	<var: #temp type: #SpurNewSpaceSpace>
	temp := pastSpace.
	pastSpace := futureSpace.
	futureSpace := temp