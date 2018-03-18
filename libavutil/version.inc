(*
 * copyright (c) 2003 Fabrice Bellard
 *
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
 * @ingroup lavu
 * Libavutil version macros
 *)
{$IFNDEF AVU_VERSION_INC}
{$DEFINE AVU_VERSION_INC}


(**
 * @addtogroup version_utils
 *
 * Useful to check and match library version in order to maintain
 * backward compatibility.
 *
 * The FFmpeg libraries follow a versioning sheme very similar to
 * Semantic Versioning (http://semver.org/)
 * The difference is that the component called PATCH is called MICRO in FFmpeg
 * and its value is reset to 100 instead of 0 to keep it above or equal to 100.
 * Also we do not increase MICRO for every bugfix or change in git master.
 *
 * Prior to FFmpeg 3.2 point releases did not change any lib version number to
 * avoid aliassing different git master checkouts.
 * Starting with FFmpeg 3.2, the released library versions will occupy
 * a separate MAJOR.MINOR that is not used on the master development branch.
 * That is if we branch a release of master 55.10.123 we will bump to 55.11.100
 * for the release and master will continue at 55.12.100 after it. Each new
 * point release will then bump the MICRO improving the usefulness of the lib
 * versions.
 *
 * @{
 *)

(**
 * @}
 *)

(**
 * @defgroup lavu_ver Version and Build diagnostics
 *
 * Macros and function useful to check at compiletime and at runtime
 * which version of libavutil is in use.
 *
 * @{
 *)


//#define LIBAVUTIL_VERSION_MAJOR  55
//#define LIBAVUTIL_VERSION_MINOR  78
//#define LIBAVUTIL_VERSION_MICRO 100
const
  LIBAVUTIL_VERSION_MAJOR =  55;
  LIBAVUTIL_VERSION_MINOR =  78;
  LIBAVUTIL_VERSION_MICRO = 100;

  LIBAVUTIL_VERSION_MAJOR_S =  '55';
  LIBAVUTIL_VERSION_MINOR_S =  '78';
  LIBAVUTIL_VERSION_MICRO_S = '100';

  LIBAVUTIL_VERSION_INT   = (LIBAVUTIL_VERSION_MAJOR shl 16) or
                            (LIBAVUTIL_VERSION_MINOR shl 8) or
                            LIBAVUTIL_VERSION_MICRO;

  LIBAVUTIL_VERSION       = '55.78.100';
  LIBAVUTIL_BUILD         = LIBAVUTIL_VERSION_INT;
  LIBAVUTIL_IDENT         = 'Lavu' + LIBAVUTIL_VERSION;


//#define LIBAVUTIL_VERSION_INT   AV_VERSION_INT(LIBAVUTIL_VERSION_MAJOR, \
//                                               LIBAVUTIL_VERSION_MINOR, \
//                                               LIBAVUTIL_VERSION_MICRO)

//#define LIBAVUTIL_VERSION       AV_VERSION(LIBAVUTIL_VERSION_MAJOR,     \
//                                           LIBAVUTIL_VERSION_MINOR,     \
//                                           LIBAVUTIL_VERSION_MICRO)

//#define LIBAVUTIL_BUILD         LIBAVUTIL_VERSION_INT

//#define LIBAVUTIL_IDENT         "Lavu" AV_STRINGIFY(LIBAVUTIL_VERSION)

(**
 * @defgroup lavu_depr_guards Deprecation Guards
 * FF_API_* defines may be placed below to indicate public API that will be
 * dropped at a future version bump. The defines themselves are not part of
 * the public API and may change, break or disappear at any time.
 *
 * @note, when bumping the major version it is recommended to manually
 * disable each FF_API_* in its own commit instead of disabling them all
 * at once through the bump. This improves the git bisect-ability of the change.
 *
 * @{
 *)

//#ifndef FF_API_VDPAU
//#define FF_API_VDPAU                    (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_VDPAU}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_VDPAU}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_XVMC
//#define FF_API_XVMC                     (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_XVMC}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_XVMC}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_OPT_TYPE_METADATA
//#define FF_API_OPT_TYPE_METADATA        (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_OPT_TYPE_METADATA}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_OPT_TYPE_METADATA}
  {$IFEND}
{$ENDIF}


//#ifndef FF_API_DLOG
//#define FF_API_DLOG                     (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_DLOG}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_DLOG}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_VAAPI
//#define FF_API_VAAPI                    (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_VAAPI}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_VAAPI}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_FRAME_QP
//#define FF_API_FRAME_QP                 (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_FRAME_QP}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_FRAME_QP}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_PLUS1_MINUS1
//#define FF_API_PLUS1_MINUS1             (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_PLUS1_MINUS1}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_PLUS1_MINUS1}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_ERROR_FRAME
//#define FF_API_ERROR_FRAME              (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_ERROR_FRAME}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_ERROR_FRAME}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_CRC_BIG_TABLE
//#define FF_API_CRC_BIG_TABLE            (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_CRC_BIG_TABLE}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_CRC_BIG_TABLE}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_PKT_PTS
//#define FF_API_PKT_PTS                  (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_PKT_PTS}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_PKT_PTS}
  {$IFEND}
{$ENDIF}

//#ifndef FF_API_CRYPTO_SIZE_T
//#define FF_API_CRYPTO_SIZE_T            (LIBAVUTIL_VERSION_MAJOR < 56)
//#endif
{$IFNDEF FF_API_CRYPTO_SIZE_T}
  {$IF LIBAVUTIL_VERSION_MAJOR < 56}
    {$DEFINE FF_API_CRYPTO_SIZE_T}
  {$IFEND}
{$ENDIF}

const
  LIB_LIBAVUTIL = 'avutil-' + LIBAVUTIL_VERSION_MAJOR_S + '.dll';


(**
 * @}
 * @}
 *)
 {$ENDIF}
