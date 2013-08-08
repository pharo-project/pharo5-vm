compiled methods
literal: offset
	self assert: method = (self iframeMethod: localFP).
	^self literal: offset ofMethod: method