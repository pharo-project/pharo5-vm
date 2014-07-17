newspeak support
maybeMarkIRCsIn: cogMethod
	<inline: true>
	self cppIf: #NewspeakVM ifTrue:
		[objectRepresentation canPinObjects ifTrue:
			[objectRepresentation markIfIRC: cogMethod nextMethodOrIRCs]]