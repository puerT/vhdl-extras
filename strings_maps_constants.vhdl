--------------------------------------------------------------------
--  _    __ __  __ ____   __   =                                  --
-- | |  / // / / // __ \ / /   =                                  --
-- | | / // /_/ // / / // /    =    .__  |/ _/_  .__   .__    __  --
-- | |/ // __  // /_/ // /___  =   /___) |  /   /   ) /   )  (_ ` --
-- |___//_/ /_//_____//_____/  =  (___  /| (_  /     (___(_ (__)  --
--                           =====     /                          --
--                            ===                                 --
-----------------------------  =  ----------------------------------
--# strings_maps_constants.vhdl - Constants for use with character mapping
--# $Id$
--# Freely available from VHDL-extras (http://vhdl-extras.org)
--#
--# Copyright � 2010 Kevin Thibedeau
--# Portions Copyright � 2001 Free Software Foundation
--#
--# LICENSING:
--#  The character_set constants after IDENTITY and the character_mapping
--#  constants LOWER_CASE_MAP, UPPER_CASE_MAP, and BASIC_MAP are adapted from
--#  the GNAT implementation of Ada.Strings.Maps.Constants (a-stmaco.ads).
--#  These portions are under copyright held by the Free Software Foundation.
--#  The adapted code is derived from GNAT version 3.15p source and licensed
--#  under modified GPLv2 terms which allow linking to non-GPL code without
--#  imposing the terms of the GPL on the final result. To maintain
--#  compatibility with the adapted portions, the entirety of this file is
--#  licensed under the original terms used by GNAT 3.15p. References to
--#  "GNAT" are assumed to apply to this file as well. These terms do not
--#  extend to those portions of the VHDL-extras library which are not licensed
--#  under the GPL.
--#
--# <GNAT licensing terms from a-stmaco.ads v1.11>
--#   GNAT is free software;  you can  redistribute it  and/or modify it under
--#   terms of the  GNU General Public License as published  by the Free Soft-
--#   ware  Foundation;  either version 2,  or (at your option) any later ver-
--#   sion.  GNAT is distributed in the hope that it will be useful, but WITH-
--#   OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY
--#   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
--#   for  more details.  You should have  received  a copy of the GNU General
--#   Public License  distributed with GNAT;  see file COPYING.  If not, write
--#   to  the Free Software Foundation,  59 Temple Place - Suite 330,  Boston,
--#   MA 02111-1307, USA.
--#
--#   As a special exception,  if other files  instantiate  generics from this
--#   unit, or you link  this unit with other files  to produce an executable,
--#   this  unit  does not  by itself cause  the resulting  executable  to  be
--#   covered  by the  GNU  General  Public  License.  This exception does not
--#   however invalidate  any other reasons why  the executable file  might be
--#   covered by the  GNU Public License.
--# <end GNAT license>
--#
--# DEPENDENCIES: strings_maps, characters_latin_1
--#
--# DESCRIPTION:
--#  This package provides constants for various character sets from the range
--#  of Latin-1 and mappings for upper case, lower case, and basic (unaccented)
--#  characters. It is a clone of the Ada'95 package
--#  Ada.Strings.Maps.Constants.
--------------------------------------------------------------------

library extras;
use extras.strings_maps.all;

package strings_maps_constants is

  constant NULL_SET : character_set := (others => false);
  constant IDENTITY : character_mapping;

  constant CONTROL_SET           : character_set;
  constant GRAPHIC_SET           : character_set;
  constant LETTER_SET            : character_set;
  constant LOWER_SET             : character_set;
  constant UPPER_SET             : character_set;
  constant BASIC_SET             : character_set;
  constant DECIMAL_DIGIT_SET     : character_set;
  constant HEXADECIMAL_DIGIT_SET : character_set;
  constant ALPHANUMERIC_SET      : character_set;
  constant SPECIAL_SET           : character_set;
  constant ISO_646_SET           : character_set;

  constant LOWER_CASE_MAP : character_mapping;
  constant UPPER_CASE_MAP : character_mapping;
  constant BASIC_MAP      : character_mapping;

end package;

library extras;
use extras.characters_latin_1.all;

package body strings_maps_constants is

  function generate_identity_mapping return character_mapping is
    variable result : character_mapping;
  begin
    for ch in character_mapping'range loop
      result(ch) := ch;
    end loop;

    return result;
  end function;

  constant IDENTITY : character_mapping := generate_identity_mapping;


  --## Constants adapted from Ada.Strings.Maps.Constants

  constant CONTROL_SET : character_set := (
    NUL                  to  USP                 => True,
    DEL                  to  c159                => True,
    others                                       => False
  );

  constant GRAPHIC_SET : character_set := (
    ' '                  to  '~'                 => True,
    No_Break_Space       to  LC_Y_Diaeresis      => True,
    others                                       => False
  );

  constant LETTER_SET : character_set := (
    'A'                  to  'Z'                 => True,
    'a'                  to  'z'                 => True,
    UC_A_Grave           to  UC_O_Diaeresis      => True,
    UC_O_Oblique_Stroke  to  LC_O_Diaeresis      => True,
    LC_O_Oblique_Stroke  to  LC_Y_Diaeresis      => True,
    others                                       => False
  );

  constant LOWER_SET : character_set := (
    'a'                  to  'z'                 => True,
    LC_German_Sharp_S    to  LC_O_Diaeresis      => True,
    LC_O_Oblique_Stroke  to  LC_Y_Diaeresis      => True,
    others                                       => False
  );

  constant UPPER_SET : character_set := (
    'A'                  to  'Z'                 => True,
    UC_A_Grave           to  UC_O_Diaeresis      => True,
    UC_O_Oblique_Stroke  to  UC_Icelandic_Thorn  => True,
    others                                       => False
  );

  constant BASIC_SET : character_set := (
    'A'                  to  'Z'                 => True,
    'a'                  to  'z'                 => True,
    UC_AE_Diphthong      to  UC_AE_Diphthong     => True,
    LC_AE_Diphthong      to  LC_AE_Diphthong     => True,
    LC_German_Sharp_S    to  LC_German_Sharp_S   => True,
    UC_Icelandic_Thorn   to  UC_Icelandic_Thorn  => True,
    LC_Icelandic_Thorn   to  LC_Icelandic_Thorn  => True,
    UC_Icelandic_Eth     to  UC_Icelandic_Eth    => True,
    LC_Icelandic_Eth     to  LC_Icelandic_Eth    => True,
    others                                       => False
  );

  constant DECIMAL_DIGIT_SET : character_set := (
    '0'                  to  '9'                 => True,
    others                                       => False
  );

  constant HEXADECIMAL_DIGIT_SET : character_set := (
    '0'                  to  '9'                 => True,
    'A'                  to  'F'                 => True,
    'a'                  to  'f'                 => True,
    others                                       => False
  );

  constant ALPHANUMERIC_SET : character_set := (
    '0'                  to  '9'                 => True,
    'A'                  to  'Z'                 => True,
    'a'                  to  'z'                 => True,
    UC_A_Grave           to  UC_O_Diaeresis      => True,
    UC_O_Oblique_Stroke  to  LC_O_Diaeresis      => True,
    LC_O_Oblique_Stroke  to  LC_Y_Diaeresis      => True,
    others                                       => False
  );

  constant SPECIAL_SET : character_set := (
    ' '                  to  '/'                 => True,
    ':'                  to  '@'                 => True,
    '['                  to  '`'                 => True,
    '{'                  to  '~'                 => True,
    No_Break_Space       to  Inverted_Question   => True,
    Multiplication_Sign  to  Multiplication_Sign => True,
    Division_Sign        to  Division_Sign       => True,
    others                                       => False
  );

  constant ISO_646_SET : character_set := (
    NUL                  to  DEL                 => True,
    others                                       => False
  );


  constant LOWER_CASE_MAP : character_mapping := (
      NUL                         &  -- NUL                             0
      SOH                         &  -- SOH                             1
      STX                         &  -- STX                             2
      ETX                         &  -- ETX                             3
      EOT                         &  -- EOT                             4
      ENQ                         &  -- ENQ                             5
      ACK                         &  -- ACK                             6
      BEL                         &  -- BEL                             7
      BS                          &  -- BS                              8
      HT                          &  -- HT                              9
      LF                          &  -- LF                             10
      VT                          &  -- VT                             11
      FF                          &  -- FF                             12
      CR                          &  -- CR                             13
      SO                          &  -- SO                             14
      SI                          &  -- SI                             15
      DLE                         &  -- DLE                            16
      DC1                         &  -- DC1                            17
      DC2                         &  -- DC2                            18
      DC3                         &  -- DC3                            19
      DC4                         &  -- DC4                            20
      NAK                         &  -- NAK                            21
      SYN                         &  -- SYN                            22
      ETB                         &  -- ETB                            23
      CAN                         &  -- CAN                            24
      EM                          &  -- EM                             25
      SUB                         &  -- SUB                            26
      ESC                         &  -- ESC                            27
      FSP                         &  -- FSP                            28
      GSP                         &  -- GSP                            29
      RSP                         &  -- RSP                            30
      USP                         &  -- USP                            31
      ' '                         &  -- ' '                            32
      '!'                         &  -- '!'                            33
      '"'                         &  -- '"'                            34
      '#'                         &  -- '#'                            35
      '$'                         &  -- '$'                            36
      '%'                         &  -- '%'                            37
      '&'                         &  -- '&'                            38
      '''                         &  -- '''                            39
      '('                         &  -- '('                            40
      ')'                         &  -- ')'                            41
      '*'                         &  -- '*'                            42
      '+'                         &  -- '+'                            43
      ','                         &  -- ','                            44
      '-'                         &  -- '-'                            45
      '.'                         &  -- '.'                            46
      '/'                         &  -- '/'                            47
      '0'                         &  -- '0'                            48
      '1'                         &  -- '1'                            49
      '2'                         &  -- '2'                            50
      '3'                         &  -- '3'                            51
      '4'                         &  -- '4'                            52
      '5'                         &  -- '5'                            53
      '6'                         &  -- '6'                            54
      '7'                         &  -- '7'                            55
      '8'                         &  -- '8'                            56
      '9'                         &  -- '9'                            57
      ':'                         &  -- ':'                            58
      ';'                         &  -- ';'                            59
      '<'                         &  -- '<'                            60
      '='                         &  -- '='                            61
      '>'                         &  -- '>'                            62
      '?'                         &  -- '?'                            63
      '@'                         &  -- '@'                            64
      'a'                         &  -- 'A'                            65
      'b'                         &  -- 'B'                            66
      'c'                         &  -- 'C'                            67
      'd'                         &  -- 'D'                            68
      'e'                         &  -- 'E'                            69
      'f'                         &  -- 'F'                            70
      'g'                         &  -- 'G'                            71
      'h'                         &  -- 'H'                            72
      'i'                         &  -- 'I'                            73
      'j'                         &  -- 'J'                            74
      'k'                         &  -- 'K'                            75
      'l'                         &  -- 'L'                            76
      'm'                         &  -- 'M'                            77
      'n'                         &  -- 'N'                            78
      'o'                         &  -- 'O'                            79
      'p'                         &  -- 'P'                            80
      'q'                         &  -- 'Q'                            81
      'r'                         &  -- 'R'                            82
      's'                         &  -- 'S'                            83
      't'                         &  -- 'T'                            84
      'u'                         &  -- 'U'                            85
      'v'                         &  -- 'V'                            86
      'w'                         &  -- 'W'                            87
      'x'                         &  -- 'X'                            88
      'y'                         &  -- 'Y'                            89
      'z'                         &  -- 'Z'                            90
      '['                         &  -- '['                            91
      '\'                         &  -- '\'                            92
      ']'                         &  -- ']'                            93
      '^'                         &  -- '^'                            94
      '_'                         &  -- '_'                            95
      '`'                         &  -- '`'                            96
      'a'                         &  -- 'a'                            97
      'b'                         &  -- 'b'                            98
      'c'                         &  -- 'c'                            99
      'd'                         &  -- 'd'                           100
      'e'                         &  -- 'e'                           101
      'f'                         &  -- 'f'                           102
      'g'                         &  -- 'g'                           103
      'h'                         &  -- 'h'                           104
      'i'                         &  -- 'i'                           105
      'j'                         &  -- 'j'                           106
      'k'                         &  -- 'k'                           107
      'l'                         &  -- 'l'                           108
      'm'                         &  -- 'm'                           109
      'n'                         &  -- 'n'                           110
      'o'                         &  -- 'o'                           111
      'p'                         &  -- 'p'                           112
      'q'                         &  -- 'q'                           113
      'r'                         &  -- 'r'                           114
      's'                         &  -- 's'                           115
      't'                         &  -- 't'                           116
      'u'                         &  -- 'u'                           117
      'v'                         &  -- 'v'                           118
      'w'                         &  -- 'w'                           119
      'x'                         &  -- 'x'                           120
      'y'                         &  -- 'y'                           121
      'z'                         &  -- 'z'                           122
      '{'                         &  -- '{'                           123
      '|'                         &  -- '|'                           124
      '}'                         &  -- '}'                           125
      '~'                         &  -- '~'                           126
      DEL                         &  -- DEL                           127
      c128                        &  -- c128                          128
      c129                        &  -- c129                          129
      c130                        &  -- c130                          130
      c131                        &  -- c131                          131
      c132                        &  -- c132                          132
      c133                        &  -- c133                          133
      c134                        &  -- c134                          134
      c135                        &  -- c135                          135
      c136                        &  -- c136                          136
      c137                        &  -- c137                          137
      c138                        &  -- c138                          138
      c139                        &  -- c139                          139
      c140                        &  -- c140                          140
      c141                        &  -- c141                          141
      c142                        &  -- c142                          142
      c143                        &  -- c143                          143
      c144                        &  -- c144                          144
      c145                        &  -- c145                          145
      c146                        &  -- c146                          146
      c147                        &  -- c147                          147
      c148                        &  -- c148                          148
      c149                        &  -- c149                          149
      c150                        &  -- c150                          150
      c151                        &  -- c151                          151
      c152                        &  -- c152                          152
      c153                        &  -- c153                          153
      c154                        &  -- c154                          154
      c155                        &  -- c155                          155
      c156                        &  -- c156                          156
      c157                        &  -- c157                          157
      c158                        &  -- c158                          158
      c159                        &  -- c159                          159
      No_Break_Space              &  -- No_Break_Space                160
      Inverted_Exclamation        &  -- Inverted_Exclamation          161
      Cent_Sign                   &  -- Cent_Sign                     162
      Pound_Sign                  &  -- Pound_Sign                    163
      Currency_Sign               &  -- Currency_Sign                 164
      Yen_Sign                    &  -- Yen_Sign                      165
      Broken_Bar                  &  -- Broken_Bar                    166
      Section_Sign                &  -- Section_Sign                  167
      Diaeresis                   &  -- Diaeresis                     168
      Copyright_Sign              &  -- Copyright_Sign                169
      Feminine_Ordinal_Indicator  &  -- Feminine_Ordinal_Indicator    170
      Left_Angle_Quotation        &  -- Left_Angle_Quotation          171
      Not_Sign                    &  -- Not_Sign                      172
      Soft_Hyphen                 &  -- Soft_Hyphen                   173
      Registered_Trade_Mark_Sign  &  -- Registered_Trade_Mark_Sign    174
      Macron                      &  -- Macron                        175
      Degree_Sign                 &  -- Degree_Sign                   176
      Plus_Minus_Sign             &  -- Plus_Minus_Sign               177
      Superscript_Two             &  -- Superscript_Two               178
      Superscript_Three           &  -- Superscript_Three             179
      Acute                       &  -- Acute                         180
      Micro_Sign                  &  -- Micro_Sign                    181
      Pilcrow_Sign                &  -- Pilcrow_Sign                  182
      Middle_Dot                  &  -- Middle_Dot                    183
      Cedilla                     &  -- Cedilla                       184
      Superscript_One             &  -- Superscript_One               185
      Masculine_Ordinal_Indicator &  -- Masculine_Ordinal_Indicator   186
      Right_Angle_Quotation       &  -- Right_Angle_Quotation         187
      Fraction_One_Quarter        &  -- Fraction_One_Quarter          188
      Fraction_One_Half           &  -- Fraction_One_Half             189
      Fraction_Three_Quarters     &  -- Fraction_Three_Quarters       190
      Inverted_Question           &  -- Inverted_Question             191
      LC_A_Grave                  &  -- UC_A_Grave                    192
      LC_A_Acute                  &  -- UC_A_Acute                    193
      LC_A_Circumflex             &  -- UC_A_Circumflex               194
      LC_A_Tilde                  &  -- UC_A_Tilde                    195
      LC_A_Diaeresis              &  -- UC_A_Diaeresis                196
      LC_A_Ring                   &  -- UC_A_Ring                     197
      LC_AE_Diphthong             &  -- UC_AE_Diphthong               198
      LC_C_Cedilla                &  -- UC_C_Cedilla                  199
      LC_E_Grave                  &  -- UC_E_Grave                    200
      LC_E_Acute                  &  -- UC_E_Acute                    201
      LC_E_Circumflex             &  -- UC_E_Circumflex               202
      LC_E_Diaeresis              &  -- UC_E_Diaeresis                203
      LC_I_Grave                  &  -- UC_I_Grave                    204
      LC_I_Acute                  &  -- UC_I_Acute                    205
      LC_I_Circumflex             &  -- UC_I_Circumflex               206
      LC_I_Diaeresis              &  -- UC_I_Diaeresis                207
      LC_Icelandic_Eth            &  -- UC_Icelandic_Eth              208
      LC_N_Tilde                  &  -- UC_N_Tilde                    209
      LC_O_Grave                  &  -- UC_O_Grave                    210
      LC_O_Acute                  &  -- UC_O_Acute                    211
      LC_O_Circumflex             &  -- UC_O_Circumflex               212
      LC_O_Tilde                  &  -- UC_O_Tilde                    213
      LC_O_Diaeresis              &  -- UC_O_Diaeresis                214
      Multiplication_Sign         &  -- Multiplication_Sign           215
      LC_O_Oblique_Stroke         &  -- UC_O_Oblique_Stroke           216
      LC_U_Grave                  &  -- UC_U_Grave                    217
      LC_U_Acute                  &  -- UC_U_Acute                    218
      LC_U_Circumflex             &  -- UC_U_Circumflex               219
      LC_U_Diaeresis              &  -- UC_U_Diaeresis                220
      LC_Y_Acute                  &  -- UC_Y_Acute                    221
      LC_Icelandic_Thorn          &  -- UC_Icelandic_Thorn            222
      LC_German_Sharp_S           &  -- LC_German_Sharp_S             223
      LC_A_Grave                  &  -- LC_A_Grave                    224
      LC_A_Acute                  &  -- LC_A_Acute                    225
      LC_A_Circumflex             &  -- LC_A_Circumflex               226
      LC_A_Tilde                  &  -- LC_A_Tilde                    227
      LC_A_Diaeresis              &  -- LC_A_Diaeresis                228
      LC_A_Ring                   &  -- LC_A_Ring                     229
      LC_AE_Diphthong             &  -- LC_AE_Diphthong               230
      LC_C_Cedilla                &  -- LC_C_Cedilla                  231
      LC_E_Grave                  &  -- LC_E_Grave                    232
      LC_E_Acute                  &  -- LC_E_Acute                    233
      LC_E_Circumflex             &  -- LC_E_Circumflex               234
      LC_E_Diaeresis              &  -- LC_E_Diaeresis                235
      LC_I_Grave                  &  -- LC_I_Grave                    236
      LC_I_Acute                  &  -- LC_I_Acute                    237
      LC_I_Circumflex             &  -- LC_I_Circumflex               238
      LC_I_Diaeresis              &  -- LC_I_Diaeresis                239
      LC_Icelandic_Eth            &  -- LC_Icelandic_Eth              240
      LC_N_Tilde                  &  -- LC_N_Tilde                    241
      LC_O_Grave                  &  -- LC_O_Grave                    242
      LC_O_Acute                  &  -- LC_O_Acute                    243
      LC_O_Circumflex             &  -- LC_O_Circumflex               244
      LC_O_Tilde                  &  -- LC_O_Tilde                    245
      LC_O_Diaeresis              &  -- LC_O_Diaeresis                246
      Division_Sign               &  -- Division_Sign                 247
      LC_O_Oblique_Stroke         &  -- LC_O_Oblique_Stroke           248
      LC_U_Grave                  &  -- LC_U_Grave                    249
      LC_U_Acute                  &  -- LC_U_Acute                    250
      LC_U_Circumflex             &  -- LC_U_Circumflex               251
      LC_U_Diaeresis              &  -- LC_U_Diaeresis                252
      LC_Y_Acute                  &  -- LC_Y_Acute                    253
      LC_Icelandic_Thorn          &  -- LC_Icelandic_Thorn            254
      LC_Y_Diaeresis                 -- LC_Y_Diaeresis                255
  );

  constant UPPER_CASE_MAP : character_mapping := (
      NUL                         &  -- NUL                             0
      SOH                         &  -- SOH                             1
      STX                         &  -- STX                             2
      ETX                         &  -- ETX                             3
      EOT                         &  -- EOT                             4
      ENQ                         &  -- ENQ                             5
      ACK                         &  -- ACK                             6
      BEL                         &  -- BEL                             7
      BS                          &  -- BS                              8
      HT                          &  -- HT                              9
      LF                          &  -- LF                             10
      VT                          &  -- VT                             11
      FF                          &  -- FF                             12
      CR                          &  -- CR                             13
      SO                          &  -- SO                             14
      SI                          &  -- SI                             15
      DLE                         &  -- DLE                            16
      DC1                         &  -- DC1                            17
      DC2                         &  -- DC2                            18
      DC3                         &  -- DC3                            19
      DC4                         &  -- DC4                            20
      NAK                         &  -- NAK                            21
      SYN                         &  -- SYN                            22
      ETB                         &  -- ETB                            23
      CAN                         &  -- CAN                            24
      EM                          &  -- EM                             25
      SUB                         &  -- SUB                            26
      ESC                         &  -- ESC                            27
      FSP                         &  -- FSP                            28
      GSP                         &  -- GSP                            29
      RSP                         &  -- RSP                            30
      USP                         &  -- USP                            31
      ' '                         &  -- ' '                            32
      '!'                         &  -- '!'                            33
      '"'                         &  -- '"'                            34
      '#'                         &  -- '#'                            35
      '$'                         &  -- '$'                            36
      '%'                         &  -- '%'                            37
      '&'                         &  -- '&'                            38
      '''                         &  -- '''                            39
      '('                         &  -- '('                            40
      ')'                         &  -- ')'                            41
      '*'                         &  -- '*'                            42
      '+'                         &  -- '+'                            43
      ','                         &  -- ','                            44
      '-'                         &  -- '-'                            45
      '.'                         &  -- '.'                            46
      '/'                         &  -- '/'                            47
      '0'                         &  -- '0'                            48
      '1'                         &  -- '1'                            49
      '2'                         &  -- '2'                            50
      '3'                         &  -- '3'                            51
      '4'                         &  -- '4'                            52
      '5'                         &  -- '5'                            53
      '6'                         &  -- '6'                            54
      '7'                         &  -- '7'                            55
      '8'                         &  -- '8'                            56
      '9'                         &  -- '9'                            57
      ':'                         &  -- ':'                            58
      ';'                         &  -- ';'                            59
      '<'                         &  -- '<'                            60
      '='                         &  -- '='                            61
      '>'                         &  -- '>'                            62
      '?'                         &  -- '?'                            63
      '@'                         &  -- '@'                            64
      'A'                         &  -- 'A'                            65
      'B'                         &  -- 'B'                            66
      'C'                         &  -- 'C'                            67
      'D'                         &  -- 'D'                            68
      'E'                         &  -- 'E'                            69
      'F'                         &  -- 'F'                            70
      'G'                         &  -- 'G'                            71
      'H'                         &  -- 'H'                            72
      'I'                         &  -- 'I'                            73
      'J'                         &  -- 'J'                            74
      'K'                         &  -- 'K'                            75
      'L'                         &  -- 'L'                            76
      'M'                         &  -- 'M'                            77
      'N'                         &  -- 'N'                            78
      'O'                         &  -- 'O'                            79
      'P'                         &  -- 'P'                            80
      'Q'                         &  -- 'Q'                            81
      'R'                         &  -- 'R'                            82
      'S'                         &  -- 'S'                            83
      'T'                         &  -- 'T'                            84
      'U'                         &  -- 'U'                            85
      'V'                         &  -- 'V'                            86
      'W'                         &  -- 'W'                            87
      'X'                         &  -- 'X'                            88
      'Y'                         &  -- 'Y'                            89
      'Z'                         &  -- 'Z'                            90
      '['                         &  -- '['                            91
      '\'                         &  -- '\'                            92
      ']'                         &  -- ']'                            93
      '^'                         &  -- '^'                            94
      '_'                         &  -- '_'                            95
      '`'                         &  -- '`'                            96
      'A'                         &  -- 'a'                            97
      'B'                         &  -- 'b'                            98
      'C'                         &  -- 'c'                            99
      'D'                         &  -- 'd'                           100
      'E'                         &  -- 'e'                           101
      'F'                         &  -- 'f'                           102
      'G'                         &  -- 'g'                           103
      'H'                         &  -- 'h'                           104
      'I'                         &  -- 'i'                           105
      'J'                         &  -- 'j'                           106
      'K'                         &  -- 'k'                           107
      'L'                         &  -- 'l'                           108
      'M'                         &  -- 'm'                           109
      'N'                         &  -- 'n'                           110
      'O'                         &  -- 'o'                           111
      'P'                         &  -- 'p'                           112
      'Q'                         &  -- 'q'                           113
      'R'                         &  -- 'r'                           114
      'S'                         &  -- 's'                           115
      'T'                         &  -- 't'                           116
      'U'                         &  -- 'u'                           117
      'V'                         &  -- 'v'                           118
      'W'                         &  -- 'w'                           119
      'X'                         &  -- 'x'                           120
      'Y'                         &  -- 'y'                           121
      'Z'                         &  -- 'z'                           122
      '{'                         &  -- '{'                           123
      '|'                         &  -- '|'                           124
      '}'                         &  -- '}'                           125
      '~'                         &  -- '~'                           126
      DEL                         &  -- DEL                           127
      c128                        &  -- c128                          128
      c129                        &  -- c129                          129
      c130                        &  -- c130                          130
      c131                        &  -- c131                          131
      c132                        &  -- c132                          132
      c133                        &  -- c133                          133
      c134                        &  -- c134                          134
      c135                        &  -- c135                          135
      c136                        &  -- c136                          136
      c137                        &  -- c137                          137
      c138                        &  -- c138                          138
      c139                        &  -- c139                          139
      c140                        &  -- c140                          140
      c141                        &  -- c141                          141
      c142                        &  -- c142                          142
      c143                        &  -- c143                          143
      c144                        &  -- c144                          144
      c145                        &  -- c145                          145
      c146                        &  -- c146                          146
      c147                        &  -- c147                          147
      c148                        &  -- c148                          148
      c149                        &  -- c149                          149
      c150                        &  -- c150                          150
      c151                        &  -- c151                          151
      c152                        &  -- c152                          152
      c153                        &  -- c153                          153
      c154                        &  -- c154                          154
      c155                        &  -- c155                          155
      c156                        &  -- c156                          156
      c157                        &  -- c157                          157
      c158                        &  -- c158                          158
      c159                        &  -- c159                          159
      No_Break_Space              &  -- No_Break_Space                160
      Inverted_Exclamation        &  -- Inverted_Exclamation          161
      Cent_Sign                   &  -- Cent_Sign                     162
      Pound_Sign                  &  -- Pound_Sign                    163
      Currency_Sign               &  -- Currency_Sign                 164
      Yen_Sign                    &  -- Yen_Sign                      165
      Broken_Bar                  &  -- Broken_Bar                    166
      Section_Sign                &  -- Section_Sign                  167
      Diaeresis                   &  -- Diaeresis                     168
      Copyright_Sign              &  -- Copyright_Sign                169
      Feminine_Ordinal_Indicator  &  -- Feminine_Ordinal_Indicator    170
      Left_Angle_Quotation        &  -- Left_Angle_Quotation          171
      Not_Sign                    &  -- Not_Sign                      172
      Soft_Hyphen                 &  -- Soft_Hyphen                   173
      Registered_Trade_Mark_Sign  &  -- Registered_Trade_Mark_Sign    174
      Macron                      &  -- Macron                        175
      Degree_Sign                 &  -- Degree_Sign                   176
      Plus_Minus_Sign             &  -- Plus_Minus_Sign               177
      Superscript_Two             &  -- Superscript_Two               178
      Superscript_Three           &  -- Superscript_Three             179
      Acute                       &  -- Acute                         180
      Micro_Sign                  &  -- Micro_Sign                    181
      Pilcrow_Sign                &  -- Pilcrow_Sign                  182
      Middle_Dot                  &  -- Middle_Dot                    183
      Cedilla                     &  -- Cedilla                       184
      Superscript_One             &  -- Superscript_One               185
      Masculine_Ordinal_Indicator &  -- Masculine_Ordinal_Indicator   186
      Right_Angle_Quotation       &  -- Right_Angle_Quotation         187
      Fraction_One_Quarter        &  -- Fraction_One_Quarter          188
      Fraction_One_Half           &  -- Fraction_One_Half             189
      Fraction_Three_Quarters     &  -- Fraction_Three_Quarters       190
      Inverted_Question           &  -- Inverted_Question             191
      UC_A_Grave                  &  -- UC_A_Grave                    192
      UC_A_Acute                  &  -- UC_A_Acute                    193
      UC_A_Circumflex             &  -- UC_A_Circumflex               194
      UC_A_Tilde                  &  -- UC_A_Tilde                    195
      UC_A_Diaeresis              &  -- UC_A_Diaeresis                196
      UC_A_Ring                   &  -- UC_A_Ring                     197
      UC_AE_Diphthong             &  -- UC_AE_Diphthong               198
      UC_C_Cedilla                &  -- UC_C_Cedilla                  199
      UC_E_Grave                  &  -- UC_E_Grave                    200
      UC_E_Acute                  &  -- UC_E_Acute                    201
      UC_E_Circumflex             &  -- UC_E_Circumflex               202
      UC_E_Diaeresis              &  -- UC_E_Diaeresis                203
      UC_I_Grave                  &  -- UC_I_Grave                    204
      UC_I_Acute                  &  -- UC_I_Acute                    205
      UC_I_Circumflex             &  -- UC_I_Circumflex               206
      UC_I_Diaeresis              &  -- UC_I_Diaeresis                207
      UC_Icelandic_Eth            &  -- UC_Icelandic_Eth              208
      UC_N_Tilde                  &  -- UC_N_Tilde                    209
      UC_O_Grave                  &  -- UC_O_Grave                    210
      UC_O_Acute                  &  -- UC_O_Acute                    211
      UC_O_Circumflex             &  -- UC_O_Circumflex               212
      UC_O_Tilde                  &  -- UC_O_Tilde                    213
      UC_O_Diaeresis              &  -- UC_O_Diaeresis                214
      Multiplication_Sign         &  -- Multiplication_Sign           215
      UC_O_Oblique_Stroke         &  -- UC_O_Oblique_Stroke           216
      UC_U_Grave                  &  -- UC_U_Grave                    217
      UC_U_Acute                  &  -- UC_U_Acute                    218
      UC_U_Circumflex             &  -- UC_U_Circumflex               219
      UC_U_Diaeresis              &  -- UC_U_Diaeresis                220
      UC_Y_Acute                  &  -- UC_Y_Acute                    221
      UC_Icelandic_Thorn          &  -- UC_Icelandic_Thorn            222
      LC_German_Sharp_S           &  -- LC_German_Sharp_S             223
      UC_A_Grave                  &  -- LC_A_Grave                    224
      UC_A_Acute                  &  -- LC_A_Acute                    225
      UC_A_Circumflex             &  -- LC_A_Circumflex               226
      UC_A_Tilde                  &  -- LC_A_Tilde                    227
      UC_A_Diaeresis              &  -- LC_A_Diaeresis                228
      UC_A_Ring                   &  -- LC_A_Ring                     229
      UC_AE_Diphthong             &  -- LC_AE_Diphthong               230
      UC_C_Cedilla                &  -- LC_C_Cedilla                  231
      UC_E_Grave                  &  -- LC_E_Grave                    232
      UC_E_Acute                  &  -- LC_E_Acute                    233
      UC_E_Circumflex             &  -- LC_E_Circumflex               234
      UC_E_Diaeresis              &  -- LC_E_Diaeresis                235
      UC_I_Grave                  &  -- LC_I_Grave                    236
      UC_I_Acute                  &  -- LC_I_Acute                    237
      UC_I_Circumflex             &  -- LC_I_Circumflex               238
      UC_I_Diaeresis              &  -- LC_I_Diaeresis                239
      UC_Icelandic_Eth            &  -- LC_Icelandic_Eth              240
      UC_N_Tilde                  &  -- LC_N_Tilde                    241
      UC_O_Grave                  &  -- LC_O_Grave                    242
      UC_O_Acute                  &  -- LC_O_Acute                    243
      UC_O_Circumflex             &  -- LC_O_Circumflex               244
      UC_O_Tilde                  &  -- LC_O_Tilde                    245
      UC_O_Diaeresis              &  -- LC_O_Diaeresis                246
      Division_Sign               &  -- Division_Sign                 247
      UC_O_Oblique_Stroke         &  -- LC_O_Oblique_Stroke           248
      UC_U_Grave                  &  -- LC_U_Grave                    249
      UC_U_Acute                  &  -- LC_U_Acute                    250
      UC_U_Circumflex             &  -- LC_U_Circumflex               251
      UC_U_Diaeresis              &  -- LC_U_Diaeresis                252
      UC_Y_Acute                  &  -- LC_Y_Acute                    253
      UC_Icelandic_Thorn          &  -- LC_Icelandic_Thorn            254

      LC_Y_Diaeresis                 -- LC_Y_Diaeresis                255
  );

  constant BASIC_MAP : character_mapping := (
      NUL                         &  -- NUL                             0
      SOH                         &  -- SOH                             1
      STX                         &  -- STX                             2
      ETX                         &  -- ETX                             3
      EOT                         &  -- EOT                             4
      ENQ                         &  -- ENQ                             5
      ACK                         &  -- ACK                             6
      BEL                         &  -- BEL                             7
      BS                          &  -- BS                              8
      HT                          &  -- HT                              9
      LF                          &  -- LF                             10
      VT                          &  -- VT                             11
      FF                          &  -- FF                             12
      CR                          &  -- CR                             13
      SO                          &  -- SO                             14
      SI                          &  -- SI                             15
      DLE                         &  -- DLE                            16
      DC1                         &  -- DC1                            17
      DC2                         &  -- DC2                            18
      DC3                         &  -- DC3                            19
      DC4                         &  -- DC4                            20
      NAK                         &  -- NAK                            21
      SYN                         &  -- SYN                            22
      ETB                         &  -- ETB                            23
      CAN                         &  -- CAN                            24
      EM                          &  -- EM                             25
      SUB                         &  -- SUB                            26
      ESC                         &  -- ESC                            27
      FSP                         &  -- FSP                            28
      GSP                         &  -- GSP                            29
      RSP                         &  -- RSP                            30
      USP                         &  -- USP                            31
      ' '                         &  -- ' '                            32
      '!'                         &  -- '!'                            33
      '"'                         &  -- '"'                            34
      '#'                         &  -- '#'                            35
      '$'                         &  -- '$'                            36
      '%'                         &  -- '%'                            37
      '&'                         &  -- '&'                            38
      '''                         &  -- '''                            39
      '('                         &  -- '('                            40
      ')'                         &  -- ')'                            41
      '*'                         &  -- '*'                            42
      '+'                         &  -- '+'                            43
      ','                         &  -- ','                            44
      '-'                         &  -- '-'                            45
      '.'                         &  -- '.'                            46
      '/'                         &  -- '/'                            47
      '0'                         &  -- '0'                            48
      '1'                         &  -- '1'                            49
      '2'                         &  -- '2'                            50
      '3'                         &  -- '3'                            51
      '4'                         &  -- '4'                            52
      '5'                         &  -- '5'                            53
      '6'                         &  -- '6'                            54
      '7'                         &  -- '7'                            55
      '8'                         &  -- '8'                            56
      '9'                         &  -- '9'                            57
      ':'                         &  -- ':'                            58
      ';'                         &  -- ';'                            59
      '<'                         &  -- '<'                            60
      '='                         &  -- '='                            61
      '>'                         &  -- '>'                            62
      '?'                         &  -- '?'                            63
      '@'                         &  -- '@'                            64
      'A'                         &  -- 'A'                            65
      'B'                         &  -- 'B'                            66
      'C'                         &  -- 'C'                            67
      'D'                         &  -- 'D'                            68
      'E'                         &  -- 'E'                            69
      'F'                         &  -- 'F'                            70
      'G'                         &  -- 'G'                            71
      'H'                         &  -- 'H'                            72
      'I'                         &  -- 'I'                            73
      'J'                         &  -- 'J'                            74
      'K'                         &  -- 'K'                            75
      'L'                         &  -- 'L'                            76
      'M'                         &  -- 'M'                            77
      'N'                         &  -- 'N'                            78
      'O'                         &  -- 'O'                            79
      'P'                         &  -- 'P'                            80
      'Q'                         &  -- 'Q'                            81
      'R'                         &  -- 'R'                            82
      'S'                         &  -- 'S'                            83
      'T'                         &  -- 'T'                            84
      'U'                         &  -- 'U'                            85
      'V'                         &  -- 'V'                            86
      'W'                         &  -- 'W'                            87
      'X'                         &  -- 'X'                            88
      'Y'                         &  -- 'Y'                            89
      'Z'                         &  -- 'Z'                            90
      '['                         &  -- '['                            91
      '\'                         &  -- '\'                            92
      ']'                         &  -- ']'                            93
      '^'                         &  -- '^'                            94
      '_'                         &  -- '_'                            95
      '`'                         &  -- '`'                            96
      'a'                         &  -- 'a'                            97
      'b'                         &  -- 'b'                            98
      'c'                         &  -- 'c'                            99
      'd'                         &  -- 'd'                           100
      'e'                         &  -- 'e'                           101
      'f'                         &  -- 'f'                           102
      'g'                         &  -- 'g'                           103
      'h'                         &  -- 'h'                           104
      'i'                         &  -- 'i'                           105
      'j'                         &  -- 'j'                           106
      'k'                         &  -- 'k'                           107
      'l'                         &  -- 'l'                           108
      'm'                         &  -- 'm'                           109
      'n'                         &  -- 'n'                           110
      'o'                         &  -- 'o'                           111
      'p'                         &  -- 'p'                           112
      'q'                         &  -- 'q'                           113
      'r'                         &  -- 'r'                           114
      's'                         &  -- 's'                           115
      't'                         &  -- 't'                           116
      'u'                         &  -- 'u'                           117
      'v'                         &  -- 'v'                           118
      'w'                         &  -- 'w'                           119
      'x'                         &  -- 'x'                           120
      'y'                         &  -- 'y'                           121
      'z'                         &  -- 'z'                           122
      '{'                         &  -- '{'                           123
      '|'                         &  -- '|'                           124
      '}'                         &  -- '}'                           125
      '~'                         &  -- '~'                           126
      DEL                         &  -- DEL                           127
      c128                        &  -- c128                          128
      c129                        &  -- c129                          129
      c130                        &  -- c130                          130
      c131                        &  -- c131                          131
      c132                        &  -- c132                          132
      c133                        &  -- c133                          133
      c134                        &  -- c134                          134
      c135                        &  -- c135                          135
      c136                        &  -- c136                          136
      c137                        &  -- c137                          137
      c138                        &  -- c138                          138
      c139                        &  -- c139                          139
      c140                        &  -- c140                          140
      c141                        &  -- c141                          141
      c142                        &  -- c142                          142
      c143                        &  -- c143                          143
      c144                        &  -- c144                          144
      c145                        &  -- c145                          145
      c146                        &  -- c146                          146
      c147                        &  -- c147                          147
      c148                        &  -- c148                          148
      c149                        &  -- c149                          149
      c150                        &  -- c150                          150
      c151                        &  -- c151                          151
      c152                        &  -- c152                          152
      c153                        &  -- c153                          153
      c154                        &  -- c154                          154
      c155                        &  -- c155                          155
      c156                        &  -- c156                          156
      c157                        &  -- c157                          157
      c158                        &  -- c158                          158
      c159                        &  -- c159                          159
      No_Break_Space              &  -- No_Break_Space                160
      Inverted_Exclamation        &  -- Inverted_Exclamation          161
      Cent_Sign                   &  -- Cent_Sign                     162
      Pound_Sign                  &  -- Pound_Sign                    163
      Currency_Sign               &  -- Currency_Sign                 164
      Yen_Sign                    &  -- Yen_Sign                      165
      Broken_Bar                  &  -- Broken_Bar                    166
      Section_Sign                &  -- Section_Sign                  167
      Diaeresis                   &  -- Diaeresis                     168
      Copyright_Sign              &  -- Copyright_Sign                169
      Feminine_Ordinal_Indicator  &  -- Feminine_Ordinal_Indicator    170
      Left_Angle_Quotation        &  -- Left_Angle_Quotation          171
      Not_Sign                    &  -- Not_Sign                      172
      Soft_Hyphen                 &  -- Soft_Hyphen                   173
      Registered_Trade_Mark_Sign  &  -- Registered_Trade_Mark_Sign    174
      Macron                      &  -- Macron                        175
      Degree_Sign                 &  -- Degree_Sign                   176
      Plus_Minus_Sign             &  -- Plus_Minus_Sign               177
      Superscript_Two             &  -- Superscript_Two               178
      Superscript_Three           &  -- Superscript_Three             179
      Acute                       &  -- Acute                         180
      Micro_Sign                  &  -- Micro_Sign                    181
      Pilcrow_Sign                &  -- Pilcrow_Sign                  182
      Middle_Dot                  &  -- Middle_Dot                    183
      Cedilla                     &  -- Cedilla                       184
      Superscript_One             &  -- Superscript_One               185
      Masculine_Ordinal_Indicator &  -- Masculine_Ordinal_Indicator   186
      Right_Angle_Quotation       &  -- Right_Angle_Quotation         187
      Fraction_One_Quarter        &  -- Fraction_One_Quarter          188
      Fraction_One_Half           &  -- Fraction_One_Half             189
      Fraction_Three_Quarters     &  -- Fraction_Three_Quarters       190
      Inverted_Question           &  -- Inverted_Question             191
      'A'                         &  -- UC_A_Grave                    192
      'A'                         &  -- UC_A_Acute                    193
      'A'                         &  -- UC_A_Circumflex               194
      'A'                         &  -- UC_A_Tilde                    195
      'A'                         &  -- UC_A_Diaeresis                196
      'A'                         &  -- UC_A_Ring                     197
      UC_AE_Diphthong             &  -- UC_AE_Diphthong               198
      'C'                         &  -- UC_C_Cedilla                  199
      'E'                         &  -- UC_E_Grave                    200
      'E'                         &  -- UC_E_Acute                    201
      'E'                         &  -- UC_E_Circumflex               202
      'E'                         &  -- UC_E_Diaeresis                203
      'I'                         &  -- UC_I_Grave                    204
      'I'                         &  -- UC_I_Acute                    205
      'I'                         &  -- UC_I_Circumflex               206
      'I'                         &  -- UC_I_Diaeresis                207
      UC_Icelandic_Eth            &  -- UC_Icelandic_Eth              208
      'N'                         &  -- UC_N_Tilde                    209
      'O'                         &  -- UC_O_Grave                    210
      'O'                         &  -- UC_O_Acute                    211
      'O'                         &  -- UC_O_Circumflex               212
      'O'                         &  -- UC_O_Tilde                    213
      'O'                         &  -- UC_O_Diaeresis                214
      Multiplication_Sign         &  -- Multiplication_Sign           215
      'O'                         &  -- UC_O_Oblique_Stroke           216
      'U'                         &  -- UC_U_Grave                    217
      'U'                         &  -- UC_U_Acute                    218
      'U'                         &  -- UC_U_Circumflex               219
      'U'                         &  -- UC_U_Diaeresis                220
      'Y'                         &  -- UC_Y_Acute                    221
      UC_Icelandic_Thorn          &  -- UC_Icelandic_Thorn            222
      LC_German_Sharp_S           &  -- LC_German_Sharp_S             223
      'a'                         &  -- LC_A_Grave                    224
      'a'                         &  -- LC_A_Acute                    225
      'a'                         &  -- LC_A_Circumflex               226
      'a'                         &  -- LC_A_Tilde                    227
      'a'                         &  -- LC_A_Diaeresis                228
      'a'                         &  -- LC_A_Ring                     229
      LC_AE_Diphthong             &  -- LC_AE_Diphthong               230
      'c'                         &  -- LC_C_Cedilla                  231
      'e'                         &  -- LC_E_Grave                    232
      'e'                         &  -- LC_E_Acute                    233
      'e'                         &  -- LC_E_Circumflex               234
      'e'                         &  -- LC_E_Diaeresis                235
      'i'                         &  -- LC_I_Grave                    236
      'i'                         &  -- LC_I_Acute                    237
      'i'                         &  -- LC_I_Circumflex               238
      'i'                         &  -- LC_I_Diaeresis                239
      LC_Icelandic_Eth            &  -- LC_Icelandic_Eth              240
      'n'                         &  -- LC_N_Tilde                    241
      'o'                         &  -- LC_O_Grave                    242
      'o'                         &  -- LC_O_Acute                    243
      'o'                         &  -- LC_O_Circumflex               244
      'o'                         &  -- LC_O_Tilde                    245
      'o'                         &  -- LC_O_Diaeresis                246
      Division_Sign               &  -- Division_Sign                 247
      'o'                         &  -- LC_O_Oblique_Stroke           248
      'u'                         &  -- LC_U_Grave                    249
      'u'                         &  -- LC_U_Acute                    250
      'u'                         &  -- LC_U_Circumflex               251
      'u'                         &  -- LC_U_Diaeresis                252
      'y'                         &  -- LC_Y_Acute                    253
      LC_Icelandic_Thorn          &  -- LC_Icelandic_Thorn            254
      'y'                            -- LC_Y_Diaeresis                255
  );

end package body;
