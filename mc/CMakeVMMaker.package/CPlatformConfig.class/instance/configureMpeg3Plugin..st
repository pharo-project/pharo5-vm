plugin extra rules
configureMpeg3Plugin: maker
	"extra rules for Mpeg3Plugin"

	maker includeDirectories: '${pluginCross}/libmpeg ${pluginCross}/libmpeg/audio ${pluginCross}/libmpeg/video'.

	maker addCrossSources: 
		#( 
		'libmpeg/bitstream.c' 
		'libmpeg/changesForSqueak.c'
		'libmpeg/audio/dct.c'
		'libmpeg/video/getpicture.c'
		'libmpeg/audio/header.c'
		'libmpeg/video/headers.c'
		'libmpeg/video/idct.c'
		'libmpeg/audio/layer1.c'
		'libmpeg/audio/layer2.c'
		'libmpeg/audio/layer3.c'
		'libmpeg/libmpeg3.c'
		'libmpeg/video/macroblocks.c'
		'libmpeg/video/mmxtest.c'
		'libmpeg/video/motion.c'
		'libmpeg/mpeg3atrack.c'
		'libmpeg/audio/mpeg3audio.c'
		'libmpeg/mpeg3demux.c'
		'libmpeg/mpeg3io.c'
		'libmpeg/mpeg3title.c'
		'libmpeg/video/mpeg3video.c'
		'libmpeg/mpeg3vtrack.c'
		'libmpeg/video/output.c'
		'libmpeg/audio/pcm.c'
		'libmpeg/video/reconstruct.c'
		'libmpeg/video/seek.c'
		'libmpeg/video/slice.c'
		
		'libmpeg/audio/synthesizers.c'
		'libmpeg/audio/tables.c'
		'libmpeg/video/vlc.c'
	).
	
	
