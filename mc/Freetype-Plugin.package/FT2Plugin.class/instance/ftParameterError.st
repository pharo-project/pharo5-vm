private
ftParameterError
	self inline: false.
	self returnTypeC: 'int'.
	errorCode := 16r00FF.	
	^interpreterProxy primitiveFail.