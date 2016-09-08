displaying
postDisplayAction
	"We have just blitted a scan line to the screen.
	Do whatever seems to be a good idea here."
	"Note: In the future we may check the time needed for this scan line and interrupt processing to give the Smalltalk code a chance to run at a certain time."

	<inline: false>

	"Check if there is any more work to do."
	(self getStartGet >= self getUsedGet and:[self aetUsedGet = 0]) ifTrue:[
		"No more entries to process"
		self statePut: GEStateCompleted.
	].
	(self currentYGet >= self fillMaxYGet) ifTrue:[
		"Out of clipping range"
		self statePut: GEStateCompleted.
	].