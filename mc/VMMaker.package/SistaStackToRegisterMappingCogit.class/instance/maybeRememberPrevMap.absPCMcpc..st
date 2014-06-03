method map
maybeRememberPrevMap: annotation absPCMcpc: mcpc
	"Remember the previous IsAbsPCReference's mcpc for collecting send and branch data."
	<inline: true>
	annotation = IsAbsPCReference ifTrue:
		[self assert: mcpc ~= 0.
		 prevMapAbsPCMcpc := mcpc]