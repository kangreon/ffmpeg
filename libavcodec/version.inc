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

(**
 * @file
 * @ingroup libavc
 * Libavcodec version macros.
 *)

//#include "libavutil/version.h"
{$I 'libavutil/version.inc'}

//#define LIBAVCODEC_VERSION_MAJOR  57
//#define LIBAVCODEC_VERSION_MINOR 107
//#define LIBAVCODEC_VERSION_MICRO 100
const
  LIBAVCODEC_VERSION_MAJOR =  57;
  LIBAVCODEC_VERSION_MINOR = 107;
  LIBAVCODEC_VERSION_MICRO = 100;

  LIBAVCODEC_VERSION_MAJOR_S =  '57';
  LIBAVCODEC_VERSION_MINOR_S = '107';
  LIBAVCODEC_VERSION_MICRO_S = '100';

  LIBAVCODEC_VERSION_INT   = (LIBAVCODEC_VERSION_MAJOR shl 16) or
                             (LIBAVCODEC_VERSION_MINOR shl 8) or
                             (LIBAVCODEC_VERSION_MICRO);

  LIBAVCODEC_VERSION       = '57.107.100';
  LIBAVCODEC_BUILD         = LIBAVCODEC_VERSION_INT;
  LIBAVCODEC_IDENT          = 'Lavu' + LIBAVCODEC_VERSION;

//#define LIBAVCODEC_VERSION_INT  AV_VERSION_INT(LIBAVCODEC_VERSION_MAJOR, \
//                                               LIBAVCODEC_VERSION_MINOR, \
//                                               LIBAVCODEC_VERSION_MICRO)

//#define LIBAVCODEC_VERSION      AV_VERSION(LIBAVCODEC_VERSION_MAJOR,    \
//                                           LIBAVCODEC_VERSION_MINOR,    \
//                                           LIBAVCODEC_VERSION_MICRO)


//#define LIBAVCODEC_BUILD        LIBAVCODEC_VERSION_INT


//#define LIBAVCODEC_IDENT        "Lavc" AV_STRINGIFY(LIBAVCODEC_VERSION)

(**
 * FF_API_* defines may be placed below to indicate public API that will be
 * dropped at a future version bump. The defines themselves are not part of
 * the public API and may change, break or disappear at any time.
 *
 * @note, when bumping the major version it is recommended to manually
 * disable each FF_API_* in its own commit instead of disabling them all
 * at once through the bump. This improves the git bisect-ability of the change.
 *)

//#ifndef FF_API_VIMA_DECODER
//#define FF_API_VIMA_DECODER     (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_VIMA_DECODER}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_VIMA_DECODER}
  {$ifend}
{$endif}

//#ifndef FF_API_AUDIO_CONVERT
//#define FF_API_AUDIO_CONVERT     (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_AUDIO_CONVERT}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_AUDIO_CONVERT}
  {$ifend}
{$endif}

//#ifndef FF_API_AVCODEC_RESAMPLE
//#define FF_API_AVCODEC_RESAMPLE  FF_API_AUDIO_CONVERT
//#endif
{$ifndef FF_API_AVCODEC_RESAMPLE}
  {$ifdef FF_API_AUDIO_CONVERT}
    {$define FF_API_AVCODEC_RESAMPLE}
  {$ifend}
{$endif}


//#ifndef FF_API_MISSING_SAMPLE
//#define FF_API_MISSING_SAMPLE    (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_MISSING_SAMPLE}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_MISSING_SAMPLE}
  {$ifend}
{$endif}

//#ifndef FF_API_LOWRES
//#define FF_API_LOWRES            (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_LOWRES}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_LOWRES}
  {$ifend}
{$endif}

//#ifndef FF_API_CAP_VDPAU
//#define FF_API_CAP_VDPAU         (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_CAP_VDPAU}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_CAP_VDPAU}
  {$ifend}
{$endif}

//#ifndef FF_API_BUFS_VDPAU
//#define FF_API_BUFS_VDPAU        (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_BUFS_VDPAU}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_BUFS_VDPAU}
  {$ifend}
{$endif}

//#ifndef FF_API_VOXWARE
//#define FF_API_VOXWARE           (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_VOXWARE}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_VOXWARE}
  {$ifend}
{$endif}

//#ifndef FF_API_SET_DIMENSIONS
//#define FF_API_SET_DIMENSIONS    (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_SET_DIMENSIONS}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_SET_DIMENSIONS}
  {$ifend}
{$endif}

//#ifndef FF_API_DEBUG_MV
//#define FF_API_DEBUG_MV          (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_DEBUG_MV}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_DEBUG_MV}
  {$ifend}
{$endif}

//#ifndef FF_API_AC_VLC
//#define FF_API_AC_VLC            (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_AC_VLC}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_AC_VLC}
  {$ifend}
{$endif}

//#ifndef FF_API_OLD_MSMPEG4
//#define FF_API_OLD_MSMPEG4       (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_OLD_MSMPEG4}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_OLD_MSMPEG4}
  {$ifend}
{$endif}

//#ifndef FF_API_ASPECT_EXTENDED
//#define FF_API_ASPECT_EXTENDED   (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_ASPECT_EXTENDED}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_ASPECT_EXTENDED}
  {$ifend}
{$endif}

//#ifndef FF_API_ARCH_ALPHA
//#define FF_API_ARCH_ALPHA        (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_ARCH_ALPHA}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_ARCH_ALPHA}
  {$ifend}
{$endif}

//#ifndef FF_API_XVMC
//#define FF_API_XVMC              (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_XVMC}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_XVMC}
  {$ifend}
{$endif}

//#ifndef FF_API_ERROR_RATE
//#define FF_API_ERROR_RATE        (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_ERROR_RATE}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_ERROR_RATE}
  {$ifend}
{$endif}

//#ifndef FF_API_QSCALE_TYPE
//#define FF_API_QSCALE_TYPE       (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_QSCALE_TYPE}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_QSCALE_TYPE}
  {$ifend}
{$endif}

//#ifndef FF_API_MB_TYPE
//#define FF_API_MB_TYPE           (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_MB_TYPE}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_MB_TYPE}
  {$ifend}
{$endif}

//#ifndef FF_API_MAX_BFRAMES
//#define FF_API_MAX_BFRAMES       (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_MAX_BFRAMES}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_MAX_BFRAMES}
  {$ifend}
{$endif}

//#ifndef FF_API_NEG_LINESIZES
//#define FF_API_NEG_LINESIZES     (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_NEG_LINESIZES}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_NEG_LINESIZES}
  {$ifend}
{$endif}

//#ifndef FF_API_EMU_EDGE
//#define FF_API_EMU_EDGE          (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_EMU_EDGE}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_EMU_EDGE}
  {$ifend}
{$endif}

//#ifndef FF_API_ARCH_SH4
//#define FF_API_ARCH_SH4          (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_ARCH_SH4}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_ARCH_SH4}
  {$ifend}
{$endif}

//#ifndef FF_API_ARCH_SPARC
//#define FF_API_ARCH_SPARC        (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_ARCH_SPARC}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_ARCH_SPARC}
  {$ifend}
{$endif}

//#ifndef FF_API_UNUSED_MEMBERS
//#define FF_API_UNUSED_MEMBERS    (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_UNUSED_MEMBERS}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_UNUSED_MEMBERS}
  {$ifend}
{$endif}

//#ifndef FF_API_IDCT_XVIDMMX
//#define FF_API_IDCT_XVIDMMX      (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_IDCT_XVIDMMX}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_IDCT_XVIDMMX}
  {$ifend}
{$endif}

//#ifndef FF_API_INPUT_PRESERVED
//#define FF_API_INPUT_PRESERVED   (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_INPUT_PRESERVED}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_INPUT_PRESERVED}
  {$ifend}
{$endif}

//#ifndef FF_API_NORMALIZE_AQP
//#define FF_API_NORMALIZE_AQP     (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_NORMALIZE_AQP}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_NORMALIZE_AQP}
  {$ifend}
{$endif}

//#ifndef FF_API_GMC
//#define FF_API_GMC               (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_GMC}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_GMC}
  {$ifend}
{$endif}

//#ifndef FF_API_MV0
//#define FF_API_MV0               (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_MV0}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_MV0}
  {$ifend}
{$endif}

//#ifndef FF_API_CODEC_NAME
//#define FF_API_CODEC_NAME        (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_CODEC_NAME}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_CODEC_NAME}
  {$ifend}
{$endif}

//#ifndef FF_API_AFD
//#define FF_API_AFD               (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_AFD}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_AFD}
  {$ifend}
{$endif}

//#ifndef FF_API_VISMV
///* XXX: don't forget to drop the -vismv documentation */
//#define FF_API_VISMV             (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_VISMV}
  (* XXX: don't forget to drop the -vismv documentation *)
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_VISMV}
  {$ifend}
{$endif}

//#ifndef FF_API_AUDIOENC_DELAY
//#define FF_API_AUDIOENC_DELAY    (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_AUDIOENC_DELAY}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_AUDIOENC_DELAY}
  {$ifend}
{$endif}

//#ifndef FF_API_VAAPI_CONTEXT
//#define FF_API_VAAPI_CONTEXT     (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_VAAPI_CONTEXT}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_VAAPI_CONTEXT}
  {$ifend}
{$endif}

//#ifndef FF_API_MERGE_SD
//#define FF_API_MERGE_SD          (LIBAVCODEC_VERSION_MAJOR < 58)
//#endif
{$ifndef FF_API_MERGE_SD}
  {$if LIBAVCODEC_VERSION_MAJOR < 58}
    {$define FF_API_MERGE_SD}
  {$ifend}
{$endif}

//#ifndef FF_API_AVCTX_TIMEBASE
//#define FF_API_AVCTX_TIMEBASE    (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_AVCTX_TIMEBASE}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_AVCTX_TIMEBASE}
  {$ifend}
{$endif}

//#ifndef FF_API_MPV_OPT
//#define FF_API_MPV_OPT           (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_MPV_OPT}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_MPV_OPT}
  {$ifend}
{$endif}

//#ifndef FF_API_STREAM_CODEC_TAG
//#define FF_API_STREAM_CODEC_TAG  (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_STREAM_CODEC_TAG}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_STREAM_CODEC_TAG}
  {$ifend}
{$endif}

//#ifndef FF_API_QUANT_BIAS
//#define FF_API_QUANT_BIAS        (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_QUANT_BIAS}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_QUANT_BIAS}
  {$ifend}
{$endif}

//#ifndef FF_API_RC_STRATEGY
//#define FF_API_RC_STRATEGY       (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_RC_STRATEGY}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_RC_STRATEGY}
  {$ifend}
{$endif}

//#ifndef FF_API_CODED_FRAME
//#define FF_API_CODED_FRAME       (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_CODED_FRAME}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_CODED_FRAME}
  {$ifend}
{$endif}

//#ifndef FF_API_MOTION_EST
//#define FF_API_MOTION_EST        (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_MOTION_EST}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_MOTION_EST}
  {$ifend}
{$endif}

//#ifndef FF_API_WITHOUT_PREFIX
//#define FF_API_WITHOUT_PREFIX    (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_WITHOUT_PREFIX}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_WITHOUT_PREFIX}
  {$ifend}
{$endif}

//#ifndef FF_API_SIDEDATA_ONLY_PKT
//#define FF_API_SIDEDATA_ONLY_PKT (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_SIDEDATA_ONLY_PKT}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_SIDEDATA_ONLY_PKT}
  {$ifend}
{$endif}

//#ifndef FF_API_VDPAU_PROFILE
//#define FF_API_VDPAU_PROFILE     (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_VDPAU_PROFILE}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_VDPAU_PROFILE}
  {$ifend}
{$endif}

//#ifndef FF_API_CONVERGENCE_DURATION
//#define FF_API_CONVERGENCE_DURATION (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_CONVERGENCE_DURATION}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_CONVERGENCE_DURATION}
  {$ifend}
{$endif}

//#ifndef FF_API_AVPICTURE
//#define FF_API_AVPICTURE         (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_AVPICTURE}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_AVPICTURE}
  {$ifend}
{$endif}

//#ifndef FF_API_AVPACKET_OLD_API
//#define FF_API_AVPACKET_OLD_API (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_AVPACKET_OLD_API}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_AVPACKET_OLD_API}
  {$ifend}
{$endif}

//#ifndef FF_API_RTP_CALLBACK
//#define FF_API_RTP_CALLBACK      (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_RTP_CALLBACK}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_RTP_CALLBACK}
  {$ifend}
{$endif}

//#ifndef FF_API_VBV_DELAY
//#define FF_API_VBV_DELAY         (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_VBV_DELAY}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_VBV_DELAY}
  {$ifend}
{$endif}

//#ifndef FF_API_CODER_TYPE
//#define FF_API_CODER_TYPE        (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_CODER_TYPE}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_CODER_TYPE}
  {$ifend}
{$endif}

//#ifndef FF_API_STAT_BITS
//#define FF_API_STAT_BITS         (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_STAT_BITS}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_STAT_BITS}
  {$ifend}
{$endif}

//#ifndef FF_API_PRIVATE_OPT
//#define FF_API_PRIVATE_OPT      (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_PRIVATE_OPT}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_PRIVATE_OPT}
  {$ifend}
{$endif}

//#ifndef FF_API_ASS_TIMING
//#define FF_API_ASS_TIMING       (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_ASS_TIMING}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_ASS_TIMING}
  {$ifend}
{$endif}

//#ifndef FF_API_OLD_BSF
//#define FF_API_OLD_BSF          (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_OLD_BSF}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_OLD_BSF}
  {$ifend}
{$endif}

//#ifndef FF_API_COPY_CONTEXT
//#define FF_API_COPY_CONTEXT     (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_COPY_CONTEXT}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_COPY_CONTEXT}
  {$ifend}
{$endif}

//#ifndef FF_API_GET_CONTEXT_DEFAULTS
//#define FF_API_GET_CONTEXT_DEFAULTS (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_GET_CONTEXT_DEFAULTS}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_GET_CONTEXT_DEFAULTS}
  {$ifend}
{$endif}

//#ifndef FF_API_NVENC_OLD_NAME
//#define FF_API_NVENC_OLD_NAME    (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_NVENC_OLD_NAME}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_NVENC_OLD_NAME}
  {$ifend}
{$endif}

//#ifndef FF_API_STRUCT_VAAPI_CONTEXT
//#define FF_API_STRUCT_VAAPI_CONTEXT (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_STRUCT_VAAPI_CONTEXT}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_STRUCT_VAAPI_CONTEXT}
  {$ifend}
{$endif}

//#ifndef FF_API_MERGE_SD_API
//#define FF_API_MERGE_SD_API      (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_MERGE_SD_API}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_MERGE_SD_API}
  {$ifend}
{$endif}

//#ifndef FF_API_TAG_STRING
//#define FF_API_TAG_STRING        (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_TAG_STRING}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_TAG_STRING}
  {$ifend}
{$endif}

//#ifndef FF_API_GETCHROMA
//#define FF_API_GETCHROMA         (LIBAVCODEC_VERSION_MAJOR < 59)
//#endif
{$ifndef FF_API_GETCHROMA}
  {$if LIBAVCODEC_VERSION_MAJOR < 59}
    {$define FF_API_GETCHROMA}
  {$ifend}
{$endif}

const
  LIB_LIBAVCODEC = 'avcodec-' + LIBAVCODEC_VERSION_MAJOR_S + '.dll';
