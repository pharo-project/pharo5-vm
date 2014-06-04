md5
md5HashMessage: aStringOrByteArray
	^ self md5HashStream: (ReadStream on: aStringOrByteArray asByteArray)
