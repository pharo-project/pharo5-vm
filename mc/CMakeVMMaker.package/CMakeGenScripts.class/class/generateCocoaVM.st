sources generation
generateCocoaVM
	| platformDirectoryName |
	"B3DAcceleratorPlugin"
	"Not using it right now"
	platformDirectoryName := (FileSystem workingDirectory parent / 'platforms') fullName.
	VMMaker default
		platformRootDirectoryName: platformDirectoryName;
		sourceDirectoryName: platformDirectoryName , '/iOS/vm/src';
		internal:
				#(#ADPCMCodecPlugin #B3DEnginePlugin #BalloonEnginePlugin #BitBltSimulation #BMPReadWriterPlugin #ClipboardExtendedPlugin #DeflatePlugin #DSAPlugin #FFIPlugin #FFTPlugin #FilePlugin #FloatArrayPlugin #GeniePlugin #HostWindowPlugin #JPEGReaderPlugin #JPEGReadWriter2Plugin #KlattSynthesizerPlugin #LargeIntegersPlugin #Matrix2x3Plugin #MacMenubarPlugin #MiscPrimitivePlugin #NewsqueakIA32ABIPlugin #ObjectiveCPlugin #RePlugin #SecurityPlugin #SocketPlugin #SoundCodecPlugin #SoundGenerationPlugin #SoundPlugin #StarSqueakPlugin #SurfacePlugin #UUIDPlugin #DropPlugin)
			external: #(#UnixOSProcessPlugin);
		generateMainVM;
		generateExternalPlugins.	"Gnuifier"
	(Gnuifier on: (platformDirectoryName , '/iOS/vm/src/vm') asFileReference pathName) gnuify