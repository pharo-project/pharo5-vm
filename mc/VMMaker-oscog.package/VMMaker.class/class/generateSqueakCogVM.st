configurations
generateSqueakCogVM
	^ VMMaker
		generate:
			(Smalltalk
				at:
					([ :choices | choices at: (UIManager default chooseFrom: choices) ifAbsent: [ ^ self ] ]
						value: #(#CoInterpreter #CoInterpreterMT)))
		and: StackToRegisterMappingCogit
		with: #(#MULTIPLEBYTECODESETS false #NewspeakVM false)
		to: 'oscogvm/src' asFileReference fullName
		platformDir: 'oscogvm/platforms' asFileReference fullName
		including:
			#(#ADPCMCodecPlugin #AsynchFilePlugin #BalloonEnginePlugin #B3DAcceleratorPlugin #BMPReadWriterPlugin #BitBltSimulation #BochsIA32Plugin #CroquetPlugin #DSAPlugin #DeflatePlugin #DropPlugin #FT2Plugin #FFTPlugin #FileCopyPlugin #FilePlugin #FloatArrayPlugin #FloatMathPlugin #GeniePlugin #HostWindowPlugin #IA32ABIPlugin #InternetConfigPlugin #JPEGReadWriter2Plugin #JPEGReaderPlugin #JoystickTabletPlugin #KlattSynthesizerPlugin #LargeIntegersPlugin #LocalePlugin #MIDIPlugin #MacMenubarPlugin #Matrix2x3Plugin #MiscPrimitivePlugin #Mpeg3Plugin #QuicktimePlugin #RePlugin #SecurityPlugin #SerialPlugin #SocketPlugin #SoundCodecPlugin #SoundGenerationPlugin #SoundPlugin #SqueakSSLPlugin #StarSqueakPlugin #ThreadedIA32FFIPlugin #UnixAioPlugin #UUIDPlugin #UnixOSProcessPlugin #Win32OSProcessPlugin #VMProfileLinuxSupportPlugin #VMProfileMacSupportPlugin)