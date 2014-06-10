weakness and ephemerality
processEphemerons
	"There are ephemerons to be scavenged.  Scavenge them and fire any whose keys are
	 still in pastSpace and/or eden.  The unscavenged ephemerons in this cycle can only be
	 fired if all the unscavenged ephemerons in this cycle are firable, because references
	 to ephemeron keys from unfired ephemerons should prevent the ephemerons with
	 those keys from firing.  So scavenge ephemerons with surviving keys, and only if none
	 are found, fire ephemerons with unreferenced keys, and scavenge them.   Read the
	 class comment for a more in-depth description of the algorithm."
	<inline: false>
	| unfiredEphemeronsScavenged |
	unfiredEphemeronsScavenged := self scavengeUnfiredEphemeronsInRememberedSet.
	self scavengeUnfiredEphemeronsOnEphemeronList ifTrue:
		[unfiredEphemeronsScavenged := true].
	unfiredEphemeronsScavenged ifFalse:
		[self fireEphemeronsInRememberedSet.
		 self fireEphemeronsOnEphemeronList]