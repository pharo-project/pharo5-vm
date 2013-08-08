snapshotting
shutDown
	"Stop player process, for example before snapshotting."

	self stopPlayerProcess.
	ReverbState := nil.
