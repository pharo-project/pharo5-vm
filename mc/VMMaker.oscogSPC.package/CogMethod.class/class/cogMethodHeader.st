translation
cogMethodHeader
	^String streamContents:
		[:s|
		CogBlockMethod printTypedefOn: s.
		s cr.
		self printTypedefOn: s]