newspeak support
maybeMarkIRCsIn: cogMethod
	<inline: true>
	NewspeakVM ifTrue:
		[objectRepresentation canPinObjects ifTrue:
			[objectRepresentation markIfIRC: cogMethod nextMethodOrIRCs]]