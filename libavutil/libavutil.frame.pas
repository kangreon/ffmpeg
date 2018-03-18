(*
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *)
unit libavutil.frame;

interface
{$I 'compiler.inc'}
{$I 'version.inc'}



(**
 * @file
 * @ingroup lavu_frame
 * reference-counted frame API
 *)

//#include <stddef.h>
//#include <stdint.h>
//
//#include "avutil.h"
//#include "buffer.h"
//#include "dict.h"
//#include "rational.h"
//#include "samplefmt.h"
//#include "pixfmt.h"
//#include "version.h"


(**
 * @defgroup lavu_frame AVFrame
 * @ingroup lavu_data
 *
 * @{
 * AVFrame is an abstraction for reference-counted raw multimedia data.
 *)

type
  PAVFrameSideDataType = ^TAVFrameSideDataType;
  TAVFrameSideDataType = (
    (**
     * The data is the AVPanScan struct defined in libavcodec.
     *)
    AV_FRAME_DATA_PANSCAN,
    (**
     * ATSC A53 Part 4 Closed Captions.
     * A53 CC bitstream is stored as uint8_t in AVFrameSideData.data.
     * The number of bytes of CC data is AVFrameSideData.size.
     *)
    AV_FRAME_DATA_A53_CC,
    (**
     * Stereoscopic 3d metadata.
     * The data is the AVStereo3D struct defined in libavutil/stereo3d.h.
     *)
    AV_FRAME_DATA_STEREO3D,
    (**
     * The data is the AVMatrixEncoding enum defined in libavutil/channel_layout.h.
     *)
    AV_FRAME_DATA_MATRIXENCODING,
    (**
     * Metadata relevant to a downmix procedure.
     * The data is the AVDownmixInfo struct defined in libavutil/downmix_info.h.
     *)
    AV_FRAME_DATA_DOWNMIX_INFO,
    (**
     * ReplayGain information in the form of the AVReplayGain struct.
     *)
    AV_FRAME_DATA_REPLAYGAIN,
    (**
     * This side data contains a 3x3 transformation matrix describing an affine
     * transformation that needs to be applied to the frame for correct
     * presentation.
     *
     * See libavutil/display.h for a detailed description of the data.
     *)
    AV_FRAME_DATA_DISPLAYMATRIX,
    (**
     * Active Format Description data consisting of a single byte as specified
     * in ETSI TS 101 154 using AVActiveFormatDescription enum.
     *)
    AV_FRAME_DATA_AFD,
    (**
     * Motion vectors exported by some codecs (on demand through the export_mvs
     * flag set in the libavcodec AVCodecContext flags2 option).
     * The data is the AVMotionVector struct defined in
     * libavutil/motion_vector.h.
     *)
    AV_FRAME_DATA_MOTION_VECTORS,
    (**
     * Recommmends skipping the specified number of samples. This is exported
     * only if the "skip_manual" AVOption is set in libavcodec.
     * This has the same format as AV_PKT_DATA_SKIP_SAMPLES.
     * @code
     * u32le number of samples to skip from start of this packet
     * u32le number of samples to skip from end of this packet
     * u8    reason for start skip
     * u8    reason for end   skip (0=padding silence, 1=convergence)
     * @endcode
     *)
    AV_FRAME_DATA_SKIP_SAMPLES,
    (**
     * This side data must be associated with an audio frame and corresponds to
     * enum AVAudioServiceType defined in avcodec.h.
     *)
    AV_FRAME_DATA_AUDIO_SERVICE_TYPE,
    (**
     * Mastering display metadata associated with a video frame. The payload is
     * an AVMasteringDisplayMetadata type and contains information about the
     * mastering display color volume.
     *)
    AV_FRAME_DATA_MASTERING_DISPLAY_METADATA,
    (**
     * The GOP timecode in 25 bit timecode format. Data format is 64-bit integer.
     * This is set on the first frame of a GOP that has a temporal reference of 0.
     *)
    AV_FRAME_DATA_GOP_TIMECODE,

    (**
     * The data represents the AVSphericalMapping structure defined in
     * libavutil/spherical.h.
     *)
    AV_FRAME_DATA_SPHERICAL,

    (**
     * Content light level (based on CTA-861.3). This payload contains data in
     * the form of the AVContentLightMetadata struct.
     *)
    AV_FRAME_DATA_CONTENT_LIGHT_LEVEL,

    (**
     * The data contains an ICC profile as an opaque octet buffer following the
     * format described by ISO 15076-1 with an optional name defined in the
     * metadata key entry "name".
     *)
    AV_FRAME_DATA_ICC_PROFILE
  );

  PAVActiveFormatDescription = ^TAVActiveFormatDescription;
  TAVActiveFormatDescription = (
    AV_AFD_SAME         = 8,
    AV_AFD_4_3          = 9,
    AV_AFD_16_9         = 10,
    AV_AFD_14_9         = 11,
    AV_AFD_4_3_SP_14_9  = 13,
    AV_AFD_16_9_SP_14_9 = 14,
    AV_AFD_SP_4_3       = 15,
  );


(**
 * Structure to hold side data for an AVFrame.
 *
 * sizeof(AVFrameSideData) is not a part of the public ABI, so new fields may be added
 * to the end with a minor bump.
 *)
  PAVFrameSideData = ^TAVFrameSideData;
  TAVFrameSideData = record
    type_: TAVFrameSideDataType;
    data: PByte;
    size: Integer;
    metadata: PAVDictionary;
    buf: PAVBufferRef;
  end;

(**
 * This structure describes decoded (raw) audio or video data.
 *
 * AVFrame must be allocated using av_frame_alloc(). Note that this only
 * allocates the AVFrame itself, the buffers for the data must be managed
 * through other means (see below).
 * AVFrame must be freed with av_frame_free().
 *
 * AVFrame is typically allocated once and then reused multiple times to hold
 * different data (e.g. a single AVFrame to hold frames received from a
 * decoder). In such a case, av_frame_unref() will free any references held by
 * the frame and reset it to its original clean state before it
 * is reused again.
 *
 * The data described by an AVFrame is usually reference counted through the
 * AVBuffer API. The underlying buffer references are stored in AVFrame.buf /
 * AVFrame.extended_buf. An AVFrame is considered to be reference counted if at
 * least one reference is set, i.e. if AVFrame.buf[0] != NULL. In such a case,
 * every single data plane must be contained in one of the buffers in
 * AVFrame.buf or AVFrame.extended_buf.
 * There may be a single buffer for all the data, or one separate buffer for
 * each plane, or anything in between.
 *
 * sizeof(AVFrame) is not a part of the public ABI, so new fields may be added
 * to the end with a minor bump.
 *
 * Fields can be accessed through AVOptions, the name string used, matches the
 * C structure field name for fields accessible through AVOptions. The AVClass
 * for AVFrame can be obtained from avcodec_get_frame_class()
 *)
const
  AV_NUM_DATA_POINTERS = 8;
(**
 * @defgroup lavu_frame_flags AV_FRAME_FLAGS
 * @ingroup lavu_frame
 * Flags describing additional frame properties.
 *
 * @{
 *)

(**
 * The frame data may be corrupted, e.g. due to decoding errors.
 *)
  AV_FRAME_FLAG_CORRUPT       = (1 shl 0);
(**
 * A flag to mark the frames which need to be decoded, but shouldn't be output.
 *)
  AV_FRAME_FLAG_DISCARD   = (1 shl 2);
(**
 * @}
 *)

  FF_DECODE_ERROR_INVALID_BITSTREAM   = 1;
  FF_DECODE_ERROR_MISSING_REFERENCE   = 2;

type
  PPAVFrame = ^^TAVFrame;
  PAVFrame = ^TAVFrame;
  TAVFrame = record
    (**
     * pointer to the picture/channel planes.
     * This might be different from the first allocated byte
     *
     * Some decoders access areas outside 0,0 - width,height, please
     * see avcodec_align_dimensions2(). Some filters and swscale can read
     * up to 16 bytes beyond the planes, if these filters are to be used,
     * then 16 extra bytes must be allocated.
     *
     * NOTE: Except for hwaccel formats, pointers not needed by the format
     * MUST be set to NULL.
     *)
    data: array[0..AV_NUM_DATA_POINTERS - 1] of PByte;

    (**
     * For video, size in bytes of each picture line.
     * For audio, size in bytes of each plane.
     *
     * For audio, only linesize[0] may be set. For planar audio, each channel
     * plane must be the same size.
     *
     * For video the linesizes should be multiples of the CPUs alignment
     * preference, this is 16 or 32 for modern desktop CPUs.
     * Some code requires such alignment other code can be slower without
     * correct alignment, for yet other it makes no difference.
     *
     * @note The linesize may be larger than the size of usable data -- there
     * may be extra padding present for performance reasons.
     *)
    linesize: array[0..AV_NUM_DATA_POINTERS - 1] of Integer;


    (**
     * pointers to the data planes/channels.
     *
     * For video, this should simply point to data[].
     *
     * For planar audio, each channel has a separate data pointer, and
     * linesize[0] contains the size of each channel buffer.
     * For packed audio, there is just one data pointer, and linesize[0]
     * contains the total size of the buffer for all channels.
     *
     * Note: Both data and extended_data should always be set in a valid frame,
     * but for planar audio with more channels that can fit in data,
     * extended_data must be used in order to access all channels.
     *)
    extended_data: PPByte;

    (**
     * @name Video dimensions
     * Video frames only. The coded dimensions (in pixels) of the video frame,
     * i.e. the size of the rectangle that contains some well-defined values.
     *
     * @note The part of the frame intended for display/presentation is further
     * restricted by the @ref cropping "Cropping rectangle".
     * @{
     *)
    width, height: Integer;
    (**
     * @}
     *)

    (**
     * number of audio samples (per channel) described by this frame
     *)
    nb_samples: Integer;

    (**
     * format of the frame, -1 if unknown or unset
     * Values correspond to enum AVPixelFormat for video frames,
     * enum AVSampleFormat for audio)
     *)
    format: Integer;

    (**
     * 1 -> keyframe, 0-> not
     *)
    key_frame: Integer;

    (**
     * Picture type of the frame.
     *)
    pict_type: TAVPictureType;

    (**
     * Sample aspect ratio for the video frame, 0/1 if unknown/unspecified.
     *)
    sample_aspect_ratio: TAVRational;

    (**
     * Presentation timestamp in time_base units (time when frame should be shown to user).
     *)
    pts: Int64;

{$ifdef FF_API_PKT_PTS}
    (**
     * PTS copied from the AVPacket that was decoded to produce this frame.
     * @deprecated use the pts field instead
     *)
    pkt_pts: Int64 deprecated;
{$endif}

    (**
     * DTS copied from the AVPacket that triggered returning this frame. (if frame threading isn't used)
     * This is also the Presentation time of this AVFrame calculated from
     * only AVPacket.dts values without pts values.
     *)
    pkt_dts: Int64;

    (**
     * picture number in bitstream order
     *)
    coded_picture_number: Integer;
    (**
     * picture number in display order
     *)
    display_picture_number: Integer;

    (**
     * quality (between 1 (good) and FF_LAMBDA_MAX (bad))
     *)
    quality: Integer;

    (**
     * for some private data of the user
     *)
    opaque: Pointer;

{$ifdef FF_API_ERROR_FRAME}
    (**
     * @deprecated unused
     *)
    error: array[0..AV_NUM_DATA_POINTERS - 1] of UInt64;
{$endif}

    (**
     * When decoding, this signals how much the picture must be delayed.
     * extra_delay = repeat_pict / (2*fps)
     *)
    repeat_pict: Integer;

    (**
     * The content of the picture is interlaced.
     *)
    interlaced_frame: Integer;

    (**
     * If the content is interlaced, is top field displayed first.
     *)
    top_field_first: Integer;

    (**
     * Tell user application that palette has changed from previous frame.
     *)
    palette_has_changed: Integer;

    (**
     * reordered opaque 64 bits (generally an integer or a double precision float
     * PTS but can be anything).
     * The user sets AVCodecContext.reordered_opaque to represent the input at
     * that time,
     * the decoder reorders values as needed and sets AVFrame.reordered_opaque
     * to exactly one of the values provided by the user through AVCodecContext.reordered_opaque
     * @deprecated in favor of pkt_pts
     *)
    reordered_opaque: Int64;

    (**
     * Sample rate of the audio data.
     *)
    sample_rate: Integer;

    (**
     * Channel layout of the audio data.
     *)
    channel_layout: UInt64;

    (**
     * AVBuffer references backing the data for this frame. If all elements of
     * this array are NULL, then this frame is not reference counted. This array
     * must be filled contiguously -- if buf[i] is non-NULL then buf[j] must
     * also be non-NULL for all j < i.
     *
     * There may be at most one AVBuffer per data plane, so for video this array
     * always contains all the references. For planar audio with more than
     * AV_NUM_DATA_POINTERS channels, there may be more buffers than can fit in
     * this array. Then the extra AVBufferRef pointers are stored in the
     * extended_buf array.
     *)
    buf: array[0..AV_NUM_DATA_POINTERS - 1] of PAVBufferRef;
//    AVBufferRef *buf[AV_NUM_DATA_POINTERS];

    (**
     * For planar audio which requires more than AV_NUM_DATA_POINTERS
     * AVBufferRef pointers, this array will hold all the references which
     * cannot fit into AVFrame.buf.
     *
     * Note that this is different from AVFrame.extended_data, which always
     * contains all the pointers. This array only contains the extra pointers,
     * which cannot fit into AVFrame.buf.
     *
     * This array is always allocated using av_malloc() by whoever constructs
     * the frame. It is freed in av_frame_unref().
     *)
    extended_buf: PPAVBufferRef;
//    AVBufferRef **extended_buf;
    (**
     * Number of elements in extended_buf.
     *)
    nb_extended_buf: Integer;

    side_data: PPAVFrameSideData;
//    AVFrameSideData **side_data;
    nb_side_data: Integer;



    (**
     * Frame flags, a combination of @ref lavu_frame_flags
     *)
    flags: Integer;

    (**
     * MPEG vs JPEG YUV range.
     * - encoding: Set by user
     * - decoding: Set by libavcodec
     *)
    color_range: TAVColorRange;

    color_primaries: TAVColorPrimaries;

    color_trc: TAVColorTransferCharacteristic;

    (**
     * YUV colorspace type.
     * - encoding: Set by user
     * - decoding: Set by libavcodec
     *)
    colorspace: TAVColorSpace;

    chroma_location: TAVChromaLocation;

    (**
     * frame timestamp estimated using various heuristics, in stream time base
     * - encoding: unused
     * - decoding: set by libavcodec, read by user.
     *)
    best_effort_timestamp: Int64;

    (**
     * reordered pos from the last AVPacket that has been input into the decoder
     * - encoding: unused
     * - decoding: Read by user.
     *)
    pkt_pos: Int64;

    (**
     * duration of the corresponding packet, expressed in
     * AVStream->time_base units, 0 if unknown.
     * - encoding: unused
     * - decoding: Read by user.
     *)
    pkt_duration: Int64;

    (**
     * metadata.
     * - encoding: Set by user.
     * - decoding: Set by libavcodec.
     *)
    metadata: PAVDictionary;

    (**
     * decode error flags of the frame, set to a combination of
     * FF_DECODE_ERROR_xxx flags if the decoder produced a frame, but there
     * were errors during the decoding.
     * - encoding: unused
     * - decoding: set by libavcodec, read by user.
     *)
    decode_error_flags: Integer;

    (**
     * number of audio channels, only used for audio.
     * - encoding: unused
     * - decoding: Read by user.
     *)
    channels: Integer;

    (**
     * size of the corresponding packet containing the compressed
     * frame.
     * It is set to a negative value if unknown.
     * - encoding: unused
     * - decoding: set by libavcodec, read by user.
     *)
    pkt_size: Integer;

{$ifdef FF_API_FRAME_QP}
    (**
     * QP table
     *)
    qscale_table: PShortInt deprecated;
    (**
     * QP store stride
     *)
    qstride: Integer deprecated;

    qscale_type: Integer deprecated;

    qp_table_buf: PAVBufferRef;
{$endif}
    (**
     * For hwaccel-format frames, this should be a reference to the
     * AVHWFramesContext describing the frame.
     *)
    hw_frames_ctx: PAVBufferRef;

    (**
     * AVBufferRef for free use by the API user. FFmpeg will never check the
     * contents of the buffer ref. FFmpeg calls av_buffer_unref() on it when
     * the frame is unreferenced. av_frame_copy_props() calls create a new
     * reference with av_buffer_ref() for the target frame's opaque_ref field.
     *
     * This is unrelated to the opaque field, although it serves a similar
     * purpose.
     *)
    opaque_ref: PAVBufferRef;

    (**
     * @anchor cropping
     * @name Cropping
     * Video frames only. The number of pixels to discard from the the
     * top/bottom/left/right border of the frame to obtain the sub-rectangle of
     * the frame intended for presentation.
     * @{
     *)
    crop_top: NativeUInt;
    crop_bottom: NativeUInt;
    crop_left: NativeUInt;
    crop_right: NativeUInt;
    (**
     * @}
     *)
  end;

(**
 * Accessors for some AVFrame fields. These used to be provided for ABI
 * compatibility, and do not need to be used anymore.
 *)
//int64_t av_frame_get_best_effort_timestamp(const AVFrame *frame);
function av_frame_get_best_effort_timestamp(const frame: PAVFrame): Int64;      cdecl; external LIB_LIBAVUTIL;
//void    av_frame_set_best_effort_timestamp(AVFrame *frame, int64_t val);
procedure av_frame_set_best_effort_timestamp(frame: PAVFrame; val: Int64);      cdecl; external LIB_LIBAVUTIL;
//int64_t av_frame_get_pkt_duration         (const AVFrame *frame);
function av_frame_get_pkt_duration(const frame: PAVFrame): Int64;               cdecl; external LIB_LIBAVUTIL;
//void    av_frame_set_pkt_duration         (AVFrame *frame, int64_t val);
procedure av_frame_set_pkt_duration(frame: PAVFrame; val: Int64);               cdecl; external LIB_LIBAVUTIL;
//int64_t av_frame_get_pkt_pos              (const AVFrame *frame);
//void    av_frame_set_pkt_pos              (AVFrame *frame, int64_t val);
//int64_t av_frame_get_channel_layout       (const AVFrame *frame);
//void    av_frame_set_channel_layout       (AVFrame *frame, int64_t val);
//int     av_frame_get_channels             (const AVFrame *frame);
//void    av_frame_set_channels             (AVFrame *frame, int     val);
//int     av_frame_get_sample_rate          (const AVFrame *frame);
//void    av_frame_set_sample_rate          (AVFrame *frame, int     val);
//AVDictionary *av_frame_get_metadata       (const AVFrame *frame);
//void          av_frame_set_metadata       (AVFrame *frame, AVDictionary *val);
//int     av_frame_get_decode_error_flags   (const AVFrame *frame);
//void    av_frame_set_decode_error_flags   (AVFrame *frame, int     val);
//int     av_frame_get_pkt_size(const AVFrame *frame);
//void    av_frame_set_pkt_size(AVFrame *frame, int val);
//AVDictionary **avpriv_frame_get_metadatap(AVFrame *frame);
function av_frame_get_pkt_pos(const frame: PAVFrame): Int64;                    cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_pkt_pos(frame: PAVFrame; val: Int64);                    cdecl; external LIB_LIBAVUTIL;
function av_frame_get_channel_layout(const frame: PAVFrame): Int64;             cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_channel_layout(frame: PAVFrame; val: Int64);             cdecl; external LIB_LIBAVUTIL;
function av_frame_get_channels(const frame: PAVFrame): Integer;                 cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_channels(frame: PAVFrame; val: Integer);                 cdecl; external LIB_LIBAVUTIL;
function av_frame_get_sample_rate(const frame: PAVFrame): Integer;              cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_sample_rate(frame: PAVFrame; val: Integer);              cdecl; external LIB_LIBAVUTIL;
function av_frame_get_metadata(const frame: PAVFrame): PAVDictionary;           cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_metadata(frame: PAVFrame; val: PAVDictionary);           cdecl; external LIB_LIBAVUTIL;
function av_frame_get_decode_error_flags(const frame: PAVFrame): Integer;       cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_decode_error_flags(frame: PAVFrame; val: Integer);       cdecl; external LIB_LIBAVUTIL;
function av_frame_get_pkt_size(const frame: PAVFrame): Integer;                 cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_pkt_size(frame: PAVFrame; val: Integer);                 cdecl; external LIB_LIBAVUTIL;
function avpriv_frame_get_metadatap(frame: PAVFrame): PPAVDictionary;           cdecl; external LIB_LIBAVUTIL;


{$ifdef FF_API_FRAME_QP}
//int8_t *av_frame_get_qp_table(AVFrame *f, int *stride, int *type);
//int av_frame_set_qp_table(AVFrame *f, AVBufferRef *buf, int stride, int type);
function av_frame_get_qp_table(f: PAVFrame; stride: PInteger;
  type_: PInteger): PSmallInt;                                                  cdecl; external LIB_LIBAVUTIL;
function av_frame_set_qp_table(f: PAVFrame; buf: PAVBufferRef; stride: Integer;
  type_: Integer): Integer;                                                     cdecl; external LIB_LIBAVUTIL;

{$endif}
//enum AVColorSpace av_frame_get_colorspace(const AVFrame *frame);
//void    av_frame_set_colorspace(AVFrame *frame, enum AVColorSpace val);
//enum AVColorRange av_frame_get_color_range(const AVFrame *frame);
//void    av_frame_set_color_range(AVFrame *frame, enum AVColorRange val);
function av_frame_get_colorspace(const frame: PAVFrame): TAVColorSpace;         cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_colorspace(frame: PAVFrame; val: TAVColorSpace);         cdecl; external LIB_LIBAVUTIL;
function av_frame_get_color_range(const frame: PAVFrame): TAVColorRange;        cdecl; external LIB_LIBAVUTIL;
procedure av_frame_set_color_range(frame: PAVFrame; val: TAVColorRange);        cdecl; external LIB_LIBAVUTIL;


(**
 * Get the name of a colorspace.
 * @return a static string identifying the colorspace; can be NULL.
 *)
//const char *av_get_colorspace_name(enum AVColorSpace val);
function av_get_colorspace_name(val: TAVColorSpace): PAnsiChar;                 cdecl; external LIB_LIBAVUTIL;

(**
 * Allocate an AVFrame and set its fields to default values.  The resulting
 * struct must be freed using av_frame_free().
 *
 * @return An AVFrame filled with default values or NULL on failure.
 *
 * @note this only allocates the AVFrame itself, not the data buffers. Those
 * must be allocated through other means, e.g. with av_frame_get_buffer() or
 * manually.
 *)
//AVFrame *av_frame_alloc(void);
function av_frame_alloc(): PAVFrame;                                            cdecl; external LIB_LIBAVUTIL;


(**
 * Free the frame and any dynamically allocated objects in it,
 * e.g. extended_data. If the frame is reference counted, it will be
 * unreferenced first.
 *
 * @param frame frame to be freed. The pointer will be set to NULL.
 *)
//void av_frame_free(AVFrame **frame);
procedure av_frame_free(frame: PPAVFrame);                                      cdecl; external LIB_LIBAVUTIL;

(**
 * Set up a new reference to the data described by the source frame.
 *
 * Copy frame properties from src to dst and create a new reference for each
 * AVBufferRef from src.
 *
 * If src is not reference counted, new buffers are allocated and the data is
 * copied.
 *
 * @warning: dst MUST have been either unreferenced with av_frame_unref(dst),
 *           or newly allocated with av_frame_alloc() before calling this
 *           function, or undefined behavior will occur.
 *
 * @return 0 on success, a negative AVERROR on error
 *)
//int av_frame_ref(AVFrame *dst, const AVFrame *src);
function av_frame_ref(dst: PAVFrame; const src: PAVFrame): Integer;             cdecl; external LIB_LIBAVUTIL;


(**
 * Create a new frame that references the same data as src.
 *
 * This is a shortcut for av_frame_alloc()+av_frame_ref().
 *
 * @return newly created AVFrame on success, NULL on error.
 *)
//AVFrame *av_frame_clone(const AVFrame *src);
function av_frame_clone(const src: PAVFrame): PAVFrame;                         cdecl; external LIB_LIBAVUTIL;

(**
 * Unreference all the buffers referenced by frame and reset the frame fields.
 *)
void av_frame_unref(AVFrame *frame);

(**
 * Move everything contained in src to dst and reset src.
 *
 * @warning: dst is not unreferenced, but directly overwritten without reading
 *           or deallocating its contents. Call av_frame_unref(dst) manually
 *           before calling this function to ensure that no memory is leaked.
 *)
//void av_frame_move_ref(AVFrame *dst, AVFrame *src);
procedure av_frame_move_ref(dst: PAVFrame; src: PAVFrame);                      cdecl; external LIB_LIBAVUTIL;

(**
 * Allocate new buffer(s) for audio or video data.
 *
 * The following fields must be set on frame before calling this function:
 * - format (pixel format for video, sample format for audio)
 * - width and height for video
 * - nb_samples and channel_layout for audio
 *
 * This function will fill AVFrame.data and AVFrame.buf arrays and, if
 * necessary, allocate and fill AVFrame.extended_data and AVFrame.extended_buf.
 * For planar formats, one buffer will be allocated for each plane.
 *
 * @warning: if frame already has been allocated, calling this function will
 *           leak memory. In addition, undefined behavior can occur in certain
 *           cases.
 *
 * @param frame frame in which to store the new buffers.
 * @param align Required buffer size alignment. If equal to 0, alignment will be
 *              chosen automatically for the current CPU. It is highly
 *              recommended to pass 0 here unless you know what you are doing.
 *
 * @return 0 on success, a negative AVERROR on error.
 *)
//int av_frame_get_buffer(AVFrame *frame, int align);
function av_frame_get_buffer(frame: PAVFrame; align: Integer): Integer;         cdecl; external LIB_LIBAVUTIL;

(**
 * Check if the frame data is writable.
 *
 * @return A positive value if the frame data is writable (which is true if and
 * only if each of the underlying buffers has only one reference, namely the one
 * stored in this frame). Return 0 otherwise.
 *
 * If 1 is returned the answer is valid until av_buffer_ref() is called on any
 * of the underlying AVBufferRefs (e.g. through av_frame_ref() or directly).
 *
 * @see av_frame_make_writable(), av_buffer_is_writable()
 *)
//int av_frame_is_writable(AVFrame *frame);
function av_frame_is_writable(frame: PAVFrame): Integer;                        cdecl; external LIB_LIBAVUTIL;


(**
 * Ensure that the frame data is writable, avoiding data copy if possible.
 *
 * Do nothing if the frame is writable, allocate new buffers and copy the data
 * if it is not.
 *
 * @return 0 on success, a negative AVERROR on error.
 *
 * @see av_frame_is_writable(), av_buffer_is_writable(),
 * av_buffer_make_writable()
 *)
//int av_frame_make_writable(AVFrame *frame);
function av_frame_make_writable(frame: PAVFrame): Integer;                      cdecl; external LIB_LIBAVUTIL;

(**
 * Copy the frame data from src to dst.
 *
 * This function does not allocate anything, dst must be already initialized and
 * allocated with the same parameters as src.
 *
 * This function only copies the frame data (i.e. the contents of the data /
 * extended data arrays), not any other properties.
 *
 * @return >= 0 on success, a negative AVERROR on error.
 *)
//int av_frame_copy(AVFrame *dst, const AVFrame *src);
function av_frame_copy(dst: PAVFrame; const src: PAVFrame): Integer;            cdecl; external LIB_LIBAVUTIL;

(**
 * Copy only "metadata" fields from src to dst.
 *
 * Metadata for the purpose of this function are those fields that do not affect
 * the data layout in the buffers.  E.g. pts, sample rate (for audio) or sample
 * aspect ratio (for video), but not width/height or channel layout.
 * Side data is also copied.
 *)
//int av_frame_copy_props(AVFrame *dst, const AVFrame *src);
function av_frame_copy_props(dst: PAVFrame; const src: PAVFrame): Integer;      cdecl; external LIB_LIBAVUTIL;

(**
 * Get the buffer reference a given data plane is stored in.
 *
 * @param plane index of the data plane of interest in frame->extended_data.
 *
 * @return the buffer reference that contains the plane or NULL if the input
 * frame is not valid.
 *)
//AVBufferRef *av_frame_get_plane_buffer(AVFrame *frame, int plane);
function av_frame_get_plane_buffer(frame: PAVFrame; plane: Integer): PAVBufferRef; cdecl; external LIB_LIBAVUTIL;


(**
 * Add a new side data to a frame.
 *
 * @param frame a frame to which the side data should be added
 * @param type type of the added side data
 * @param size size of the side data
 *
 * @return newly added side data on success, NULL on error
 *)
//AVFrameSideData *av_frame_new_side_data(AVFrame *frame,
//                                        enum AVFrameSideDataType type,
//                                        int size);
function av_frame_new_side_data(frame: PAVFrame; type_: TAVFrameSideDataType;
  size: Integer): PAVFrameSideData;                                             cdecl; external LIB_LIBAVUTIL;

(**
 * @return a pointer to the side data of a given type on success, NULL if there
 * is no side data with such type in this frame.
 *)
//AVFrameSideData *av_frame_get_side_data(const AVFrame *frame,
//                                        enum AVFrameSideDataType type);
function av_frame_get_side_data(const frame: PAVFrame;
  type_: TAVFrameSideDataType): PAVFrameSideData;                               cdecl; external LIB_LIBAVUTIL;

(**
 * If side data of the supplied type exists in the frame, free it and remove it
 * from the frame.
 *)
//void av_frame_remove_side_data(AVFrame *frame, enum AVFrameSideDataType type);
procedure av_frame_remove_side_data(frame: PAVFrame; type_: TAVFrameSideDataType); cdecl; external LIB_LIBAVUTIL;


(**
 * Flags for frame cropping.
 *)
//enum {
    (**
     * Apply the maximum possible cropping, even if it requires setting the
     * AVFrame.data[] entries to unaligned pointers. Passing unaligned data
     * to FFmpeg API is generally not allowed, and causes undefined behavior
     * (such as crashes). You can pass unaligned data only to FFmpeg APIs that
     * are explicitly documented to accept it. Use this flag only if you
     * absolutely know what you are doing.
     *)
const
  AV_FRAME_CROP_UNALIGNED     = 1 shl 0;
//};

(**
 * Crop the given video AVFrame according to its crop_left/crop_top/crop_right/
 * crop_bottom fields. If cropping is successful, the function will adjust the
 * data pointers and the width/height fields, and set the crop fields to 0.
 *
 * In all cases, the cropping boundaries will be rounded to the inherent
 * alignment of the pixel format. In some cases, such as for opaque hwaccel
 * formats, the left/top cropping is ignored. The crop fields are set to 0 even
 * if the cropping was rounded or ignored.
 *
 * @param frame the frame which should be cropped
 * @param flags Some combination of AV_FRAME_CROP_* flags, or 0.
 *
 * @return >= 0 on success, a negative AVERROR on error. If the cropping fields
 * were invalid, AVERROR(ERANGE) is returned, and nothing is changed.
 *)
//int av_frame_apply_cropping(AVFrame *frame, int flags);
function av_frame_apply_cropping(frame: PAVFrame; flags: Integer): Integer;     cdecl; external LIB_LIBAVUTIL;

(**
 * @return a string identifying the side data type
 *)
//const char *av_frame_side_data_name(enum AVFrameSideDataType type);
function av_frame_side_data_name(type_: TAVFrameSideDataType): PAnsiChar;       cdecl; external LIB_LIBAVUTIL;

(**
 * @}
 *)

implementation

end.
