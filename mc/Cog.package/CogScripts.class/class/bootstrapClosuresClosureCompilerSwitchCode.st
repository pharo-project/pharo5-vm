closure scripts
bootstrapClosuresClosureCompilerSwitchCode
	^'
!Parser methodsFor: ''public access'' stamp: ''eem 5/15/2008 15:44''!
encoder
	encoder isNil ifTrue:
		[encoder := EncoderForV3PlusClosures new].
	^encoder! !'