unit vorbis_parser;
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

interface

{$I 'compiler.inc'}
{$I 'version.inc'}

(**
 * @file
 * A public API for Vorbis parsing
 *
 * Determines the duration for each packet.
 *)

//typedef struct AVVorbisParseContext AVVorbisParseContext;
type
  TAVVorbisParseContext = record end;
  AVVorbisParseContext = TAVVorbisParseContext;
  PAVVorbisParseContext = ^TAVVorbisParseContext;

(**
 * Allocate and initialize the Vorbis parser using headers in the extradata.
 *)
//AVVorbisParseContext *av_vorbis_parse_init(const uint8_t *extradata,
//                                           int extradata_size);
function av_vorbis_parse_init(const extradata: PByte;
  extradata_size: Integer): PAVVorbisParseContext;                              cdecl; external LIB_LIBAVCODEC;

(**
 * Free the parser and everything associated with it.
 *)
//void av_vorbis_parse_free(AVVorbisParseContext **s);
procedure av_vorbis_parse_free(var s: PAVVorbisParseContext);                   cdecl; external LIB_LIBAVCODEC;

//#define VORBIS_FLAG_HEADER  0x00000001
//#define VORBIS_FLAG_COMMENT 0x00000002
//#define VORBIS_FLAG_SETUP   0x00000004
const
  VORBIS_FLAG_HEADER  = $00000001;
  VORBIS_FLAG_COMMENT = $00000002;
  VORBIS_FLAG_SETUP   = $00000004;

(**
 * Get the duration for a Vorbis packet.
 *
 * If @p flags is @c NULL,
 * special frames are considered invalid.
 *
 * @param s        Vorbis parser context
 * @param buf      buffer containing a Vorbis frame
 * @param buf_size size of the buffer
 * @param flags    flags for special frames
 *)
//int av_vorbis_parse_frame_flags(AVVorbisParseContext *s, const uint8_t *buf,
//                                int buf_size, int *flags);
function av_vorbis_parse_frame_flags(s: PAVVorbisParseContext; const buf: PByte;
  buf_size: Integer; var flags: Integer): Integer;                              cdecl; external LIB_LIBAVCODEC;

(**
 * Get the duration for a Vorbis packet.
 *
 * @param s        Vorbis parser context
 * @param buf      buffer containing a Vorbis frame
 * @param buf_size size of the buffer
 *)
//int av_vorbis_parse_frame(AVVorbisParseContext *s, const uint8_t *buf,
//                          int buf_size);
function av_vorbis_parse_frame(s: PAVVorbisParseContext; const buf: PByte;
  buf_size: Integer): Integer;                                                  cdecl; external LIB_LIBAVCODEC;


//void av_vorbis_parse_reset(AVVorbisParseContext *s);
procedure av_vorbis_parse_reset(s: PAVVorbisParseContext);                      cdecl; external LIB_LIBAVCODEC;

implementation

end.
