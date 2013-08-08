settings
soundQuickStart
	"Attempt to start sounds immediately. Should always be on unless it causes vm to crash"
	^SoundsShouldStartQuick  ifNil: [self defaultQuickStartForPlatform]