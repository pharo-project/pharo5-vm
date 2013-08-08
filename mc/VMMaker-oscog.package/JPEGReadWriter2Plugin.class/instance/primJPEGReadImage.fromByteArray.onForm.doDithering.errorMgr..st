primitives
primJPEGReadImage: aJPEGDecompressStruct fromByteArray: source onForm: form doDithering: ditherFlag errorMgr: aJPEGErrorMgr2Struct

	| pcinfo pjerr buffer rowStride formBits formDepth i j formPix ok rOff gOff bOff rOff2 gOff2 bOff2 formWidth formHeight pixPerWord formPitch formBitsSize sourceSize r1 r2 g1 g2 b1 b2 formBitsOops dmv1 dmv2 di dmi dmo |
	<export: true>
	<var: #pcinfo type: 'j_decompress_ptr '>
	<var: #pjerr type: 'error_ptr2 '>
	<var: #buffer type: 'JSAMPARRAY '>
	<var: #formBits type: 'unsigned * '>

	self
		primitive: 'primJPEGReadImagefromByteArrayonFormdoDitheringerrorMgr'
		parameters: #(ByteArray ByteArray Form Boolean ByteArray).

	"Avoid warnings when saving method"
	 pcinfo := nil. pjerr := nil. buffer := nil. rowStride := nil.
		formDepth := nil. formBits := nil. i := nil. j := nil. formPix := nil.
		ok := nil. rOff := nil. gOff := nil. bOff := nil. rOff2 := nil. gOff2 := nil. bOff2 := nil. sourceSize := nil.
		r1 := nil. r2 := nil. g1 := nil. g2 := nil. b1 := nil. b2 := nil.
		dmv1 := nil. dmv2 := nil. di := nil. dmi := nil. dmo := nil.
		pcinfo. pjerr. buffer. rowStride. formBits. formDepth. i. j. formPix. ok.
		rOff. gOff. bOff. rOff2. gOff2. bOff2. sourceSize.
		r1. r2. g1.g2. b1. b2. dmv1. dmv2. di. dmi. dmo.

	formBitsOops := interpreterProxy fetchPointer: 0 ofObject: form.
	formDepth := interpreterProxy fetchInteger: 3 ofObject: form.

	"Various parameter checks"
	self cCode: '
		interpreterProxy->success
			((interpreterProxy->stSizeOf(interpreterProxy->stackValue(4))) >= (sizeof(struct jpeg_decompress_struct)));
		interpreterProxy->success
			((interpreterProxy->stSizeOf(interpreterProxy->stackValue(0))) >= (sizeof(struct error_mgr2))); 
		if (interpreterProxy->failed()) return null;
	' inSmalltalk: [].
	formWidth := (self cCode: '((j_decompress_ptr)aJPEGDecompressStruct)->image_width' inSmalltalk: [0]).
	formHeight := (self cCode: '((j_decompress_ptr)aJPEGDecompressStruct)->image_height' inSmalltalk: [0]).
	pixPerWord := 32 // formDepth.
	formPitch := formWidth + (pixPerWord-1) // pixPerWord * 4.
	formBitsSize := interpreterProxy byteSizeOf: formBitsOops.
	interpreterProxy success: 
		((interpreterProxy isWordsOrBytes: formBitsOops)
			and: [formBitsSize = (formPitch * formHeight)]).
	interpreterProxy failed ifTrue: [^ nil].
	formBits := interpreterProxy firstIndexableField: formBitsOops.

	self cCode: '
		sourceSize = interpreterProxy->stSizeOf(interpreterProxy->stackValue(3));
		if (sourceSize == 0) {
			interpreterProxy->success(false);
			return null;
		}
		pcinfo = (j_decompress_ptr)aJPEGDecompressStruct;
		pjerr = (error_ptr2)aJPEGErrorMgr2Struct;
		pcinfo->err = jpeg_std_error(&pjerr->pub);
		pjerr->pub.error_exit = error_exit;
		ok = 1;
		if (setjmp(pjerr->setjmp_buffer)) {
			jpeg_destroy_decompress(pcinfo);
			ok = 0;
		}
		if (ok) {
			ok = jpeg_mem_src_newLocationOfData(pcinfo, source, sourceSize);
			if (ok) {
				/* Dither Matrix taken from Form>>orderedDither32To16, but rewritten for this method. */
				int ditherMatrix1[] = { 2, 0, 14, 12, 1, 3, 13, 15 };
				int ditherMatrix2[] = { 10, 8, 6, 4, 9, 11, 5, 7 };
 				jpeg_start_decompress(pcinfo);
				rowStride = pcinfo->output_width * pcinfo->output_components;
				if (pcinfo->out_color_components == 3) {
					rOff = 0; gOff = 1; bOff = 2;
					rOff2 = 3; gOff2 = 4; bOff2 = 5;
				} else {
					rOff = 0; gOff = 0; bOff = 0;
					rOff2 = 1; gOff2 = 1; bOff2 = 1;
				}
				/* Make a one-row-high sample array that will go away when done with image */
				buffer = (*(pcinfo->mem)->alloc_sarray)
					((j_common_ptr) pcinfo, JPOOL_IMAGE, rowStride, 1);

				/* Step 6: while (scan lines remain to be read) */
				/*           jpeg_read_scanlines(...); */

				/* Here we use the library state variable cinfo.output_scanline as the
				 * loop counter, so that we dont have to keep track ourselves.
				 */
				while (pcinfo->output_scanline < pcinfo->output_height) {
					/* jpeg_read_scanlines expects an array of pointers to scanlines.
					 * Here the array is only one element long, but you could ask for
					 * more than one scanline at a time if thats more convenient.
					 */
					(void) jpeg_read_scanlines(pcinfo, buffer, 1);

					switch (formDepth) {
						case 32:
							for(i = 0, j = 0; i < rowStride; i +=(pcinfo->out_color_components), j++) {
								formPix = (255 << 24) | (buffer[0][i+rOff] << 16) | (buffer[0][i+gOff] << 8) | buffer[0][i+bOff];
								if (formPix == 0) formPix = 1;
								formBits [ ((pcinfo->output_scanline - 1) * (pcinfo->image_width)) + j ] = formPix;
							}
							break;

						case 16:
							for(i = 0, j = 0; i < rowStride; i +=(pcinfo->out_color_components*2), j++) {
								r1 = buffer[0][i+rOff];
								r2 = buffer[0][i+rOff2];
								g1 = buffer[0][i+gOff];
								g2 = buffer[0][i+gOff2];
								b1 = buffer[0][i+bOff];
								b2 = buffer[0][i+bOff2];

								if (!ditherFlag) {
									r1 = r1 >> 3;
									r2 = r2 >> 3;
									g1 = g1 >> 3;
									g2 = g2 >> 3;
									b1 = b1 >> 3;
									b2 = b2 >> 3;
								} else {
									/* Do 4x4 ordered dithering. Taken from Form>>orderedDither32To16 */
									dmv1 = ditherMatrix1[ ((pcinfo->output_scanline & 3 )<< 1) | (j&1) ];
									dmv2 = ditherMatrix2[ ((pcinfo->output_scanline & 3 )<< 1) | (j&1) ];

									di = (r1 * 496) >> 8; dmi = di & 15; dmo = di >> 4;
									if(dmv1 < dmi) { r1 = dmo+1; } else { r1 = dmo; };
									di = (g1 * 496) >> 8; dmi = di & 15; dmo = di >> 4;
									if(dmv1 < dmi) { g1 = dmo+1; } else { g1 = dmo; };
									di = (b1 * 496) >> 8; dmi = di & 15; dmo = di >> 4;
									if(dmv1 < dmi) { b1 = dmo+1; } else { b1 = dmo; };

									di = (r2 * 496) >> 8; dmi = di & 15; dmo = di >> 4;
									if(dmv2 < dmi) { r2 = dmo+1; } else { r2 = dmo; };
									di = (g2 * 496) >> 8; dmi = di & 15; dmo = di >> 4;
									if(dmv2 < dmi) { g2 = dmo+1; } else { g2 = dmo; };
									di = (b2 * 496) >> 8; dmi = di & 15; dmo = di >> 4;
									if(dmv2 < dmi) { b2 = dmo+1; } else { b2 = dmo; };
								}

								formPix = (r1 << 10) | (g1 << 5) | b1;
								if (!formPix) formPix = 1;
								formPix = (formPix << 16) | (r2 << 10) | (g2 << 5) | b2;
								if (!(formPix & 65535)) formPix = formPix | 1;
								formBits [ ((pcinfo->output_scanline - 1) * (pcinfo->image_width)) / 2 + j ] = formPix;
							}
							break;
					}
				}
				jpeg_finish_decompress(pcinfo);
			}
			jpeg_destroy_decompress(pcinfo);
		}
	' inSmalltalk: [].