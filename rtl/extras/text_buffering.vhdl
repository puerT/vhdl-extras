--------------------------------------------------------------------
--  _    __ __  __ ____   __   =                                  --
-- | |  / // / / // __ \ / /   =                                  --
-- | | / // /_/ // / / // /    =    .__  |/ _/_  .__   .__    __  --
-- | |/ // __  // /_/ // /___  =   /___) |  /   /   ) /   )  (_ ` --
-- |___//_/ /_//_____//_____/  =  (___  /| (_  /     (___(_ (__)  --
--                           =====     /                          --
--                            ===                                 --
-----------------------------  =  ----------------------------------
--# text_buffering.vhdl - Procedures to store buffered text
--# $Id$
--# Freely available from VHDL-extras (http://code.google.com/p/vhdl-extras)
--#
--# Copyright � 2010 Kevin Thibedeau
--# (kevin 'period' thibedeau 'at' gmail 'punto' com)
--#
--# Permission is hereby granted, free of charge, to any person obtaining a
--# copy of this software and associated documentation files (the "Software"),
--# to deal in the Software without restriction, including without limitation
--# the rights to use, copy, modify, merge, publish, distribute, sublicense,
--# and/or sell copies of the Software, and to permit persons to whom the
--# Software is furnished to do so, subject to the following conditions:
--#
--# The above copyright notice and this permission notice shall be included in
--# all copies or substantial portions of the Software.
--#
--# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
--# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
--# DEALINGS IN THE SOFTWARE.
--#
--# DEPENDENCIES: strings_unbounded
--#
--# DESCRIPTION:
--#  This package provides a facility for storing buffered text. It can be used
--#  to represent the contents of a text file as a linked list of dynamically
--#  allocated strings for each line. A text file can be read into a buffer and
--#  the resulting data structure can be incorporated into records passable
--#  to procedures without having to maintain a separate file handle.
--------------------------------------------------------------------

use std.textio.all;

library extras;
use extras.strings_unbounded.string_acc;

package text_buffering is

  type buffer_line;
  type buffer_line_acc is access buffer_line;

  type buffer_line is record
    s : string_acc;
    succ : buffer_line_acc;
  end record;

  type text_buffer is record
    buf          : buffer_line_acc;
    buf_tail     : buffer_line_acc;
    cur_line     : buffer_line_acc;
    cur_line_num : natural;
    lines        : natural;
  end record;

  --## Load a text file object into a buffer
  procedure load_buffer( file fh : text; buf : out text_buffer );

  --## Load a file into a buffer
  procedure load_buffer( fname : in string; buf : out text_buffer );


  --## Append a text file object to an existing buffer
  procedure append( file fh : text; buf : inout text_buffer );

  --## Append a text file to an existing buffer
  procedure append( fname : in string; buf : inout text_buffer );


  --## Append a string to a buffer
  procedure append( variable one_line : in string_acc; buf : inout text_buffer );


  --## Write a buffer to a text file object
  procedure write( file fh : text; variable buf : in text_buffer );

  --## Retrieve the current line from a buffer
  procedure nextline( buf : inout text_buffer; tl : inout string_acc );

  --## Move to a specific line in the buffer
  procedure setline( buf : inout text_buffer; n : in positive );

  --## Check if the end of the buffer has been reached
  procedure endbuffer( variable buf : in text_buffer; at_end : out boolean );

  --## Deallocate the buffer contents
  procedure free( buf : inout text_buffer );

end package;

use std.textio.all;

package body text_buffering is

  --## Load a text file object into a buffer
  procedure load_buffer( file fh : text; buf : out text_buffer ) is
    variable tl : string_acc;
    variable cur, succ : buffer_line_acc;
    variable tb : text_buffer;
  begin

    -- get the first line
    readline(fh, tl);
    tb.buf := new buffer_line;
    tb.buf.s := tl;
    tb.cur_line_num := 1;
    tb.cur_line := tb.buf;
    tb.lines := 1;

    cur := tb.buf;
    while(not endfile(fh)) loop
      tl := null;
      readline(fh, tl);
      succ := new buffer_line;
      succ.s := tl;
      cur.succ := succ;
      cur := succ;
      tb.lines := tb.lines + 1;
    end loop;

    tb.buf_tail := cur;
    buf := tb;

  end procedure;

  --## Load a file into a buffer
  procedure load_buffer( fname : in string; buf : out text_buffer ) is
    file fh : text;
    variable fstatus : file_open_status;
  begin

    file_open(fstatus, fh, fname, read_mode);
    assert fstatus = open_ok
      report "Unable to open file for load_buffer(): " & fname
      severity failure;

    load_buffer(fh, buf);

    file_close(fh);

  end procedure;


  --## Append a text file object to an existing buffer
  procedure append( file fh : text; buf : inout text_buffer ) is
    variable tb : text_buffer;
  begin
    load_buffer(fh, tb);

    buf.buf_tail.succ := tb.buf;

    if buf.cur_line = null then -- Fix pointer
      buf.cur_line := buf.buf_tail.succ;
    end if;

    buf.buf_tail := tb.buf_tail;
    buf.lines := buf.lines + tb.lines;

  end procedure;


  --## Append a text file to an existing buffer
  procedure append( fname : in string; buf : inout text_buffer ) is
    file fh : text;
    variable fstatus : file_open_status;
  begin

    file_open(fstatus, fh, fname, read_mode);
    assert fstatus = open_ok
      report "Unable to open file for append(): " & fname
      severity failure;

    append(fh, buf);

    file_close(fh);

  end procedure;


  --## Append a string to a buffer
  procedure append( variable one_line : in string_acc; buf : inout text_buffer ) is
  begin
    if buf.buf_tail /= null then
      buf.buf_tail.succ := new buffer_line;
      buf.buf_tail.succ.s := new string'(one_line.all);
      buf.buf_tail := buf.buf_tail.succ;
      buf.lines := buf.lines + 1;
    else
      buf.buf := new buffer_line;
      buf.buf.s := new string'(one_line.all);

      buf.buf_tail := buf.buf;
      buf.cur_line := buf.buf;
      buf.cur_line_num := 1;
      buf.lines := 1;
    end if;
  end procedure;


  --## Write a buffer to a text file object
  procedure write( file fh : text; variable buf : in text_buffer ) is
    variable cur : buffer_line_acc;
    variable ln : string_acc;
  begin
    cur := buf.buf;
    while cur /= null loop
      ln := new string'(cur.s.all);
      writeline(fh, ln);
      cur := cur.succ;
    end loop;
  end procedure;


  --## Retrieve the current line from a buffer
  procedure nextline( buf : inout text_buffer; tl : inout string_acc ) is
  begin
    if buf.buf /= null and buf.cur_line /= null then
      tl := new string'(buf.cur_line.s.all);
      buf.cur_line := buf.cur_line.succ;
      buf.cur_line_num := buf.cur_line_num + 1;
    else
      tl := null;
    end if;
  end procedure;


  --## Move to a specific line in the buffer
  procedure setline( buf : inout text_buffer; n : in positive ) is
    variable cur : buffer_line_acc;
    variable lnum : natural := 0;
  begin

    cur := buf.buf;
    while cur /= null loop
      lnum := lnum + 1;

      if lnum = n then
        exit;
      end if;
      cur := cur.succ;
    end loop;

    buf.cur_line := cur;
    buf.cur_line_num := n;
  end procedure;


  --## Check if the end of the buffer has been reached
  procedure endbuffer( variable buf : in text_buffer; at_end : out boolean ) is
  begin
    at_end := buf.cur_line = null;
  end procedure;


  --## Deallocate the buffer contents
  procedure free( buf : inout text_buffer ) is
    variable cur, succ : buffer_line_acc;
  begin
    cur := buf.buf;
    while cur /= null loop
      succ := cur.succ;
      deallocate(cur.s);
      deallocate(cur);
      cur := succ;
    end loop;

    buf.buf := null;
    buf.cur_line := null;
  end procedure;


end package body;
