--------------------------------------------------------------------
--  _    __ __  __ ____   __   =                                  --
-- | |  / // / / // __ \ / /   =                                  --
-- | | / // /_/ // / / // /    =    .__  |/ _/_  .__   .__    __  --
-- | |/ // __  // /_/ // /___  =   /___) |  /   /   ) /   )  (_ ` --
-- |___//_/ /_//_____//_____/  =  (___  /| (_  /     (___(_ (__)  --
--                           =====     /                          --
--                            ===                                 --
-----------------------------  =  ----------------------------------
--# memory_pkg.vhdl - Generic memories
--# $Id$
--# Freely available from VHDL-extras (http://code.google.com/p/vhdl-extras)
--#
--# Copyright © 2014 Kevin Thibedeau
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
--# DEPENDENCIES: none
--#
--# DESCRIPTION:
--#  This package provides general purpose components for inferred RAM and ROM.
--#  These memories share a SYNC_READ generic which will optionally generate synchronous
--#  or asynchronous read ports for each instance. On Xilinx devices asynchronous
--#  read forces the synthesis of distributed RAM using LUTs rather than BRAMs.
--#
--#  The ROM component gets its contents using synthesizable file IO to read a list
--#  of binary or hex values.
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package memory_pkg is

  component dual_port_ram is
    generic (
      MEM_SIZE  : positive;
      SYNC_READ : boolean := true
    );
    port (
      Wr_clock : in std_ulogic;
      We       : in std_ulogic;
      Wr_addr  : in natural range 0 to MEM_SIZE-1;
      Wr_data  : in std_ulogic_vector;

      Rd_clock : in std_ulogic;
      Re       : in std_ulogic;
      Rd_addr  : in natural range 0 to MEM_SIZE-1;
      Rd_data  : out std_ulogic_vector
    );
  end component;

  type rom_format is (BINARY_TEXT, HEX_TEXT);

  component rom is
    generic (
      ROM_FILE  : string;
      FORMAT    : rom_format;
      MEM_SIZE  : positive;
      SYNC_READ : boolean := true
    );
    port (
      Clock : in std_ulogic;
      Re    : in std_ulogic;
      Addr  : in natural range 0 to MEM_SIZE-1;
      Data  : out std_ulogic_vector
    );
  end component;


end package;



library ieee;
use ieee.std_logic_1164.all;

entity dual_port_ram is
  generic (
    MEM_SIZE  : positive;
    SYNC_READ : boolean := true
  );
  port (
    Wr_clock : in std_ulogic;
    We       : in std_ulogic;
    Wr_addr  : in natural range 0 to MEM_SIZE-1;
    Wr_data  : in std_ulogic_vector;

    Rd_clock : in std_ulogic;
    Re       : in std_ulogic;
    Rd_addr  : in natural range 0 to MEM_SIZE-1;
    Rd_data  : out std_ulogic_vector
  );
end entity;

architecture rtl of dual_port_ram is
  type ram_type is array (0 to MEM_SIZE-1) of std_ulogic_vector(Wr_data'length-1 downto 0);
  signal ram : ram_type;

  signal sync_rdata : std_ulogic_vector(Rd_data'range);
begin

  wr: process(Wr_clock)
  begin
    if rising_edge(Wr_clock) then
      if We = '1' then
        ram(Wr_addr) <= Wr_data;
      end if;
    end if;
  end process;

  sread: if SYNC_READ = true generate
  rd: process(Rd_clock)
  begin
    if rising_edge(Rd_clock) then
      if Re = '1' then
        sync_rdata <= ram(Rd_addr);
      end if;
    end if;
  end process;
  end generate;

  Rd_data <= ram(Rd_addr) when SYNC_READ = false else sync_rdata;

end architecture;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;
use ieee.std_logic_textio.all;

use std.textio.all;

library extras;
use extras.memory_pkg.all;

entity rom is
  generic (
    ROM_FILE  : string;
    FORMAT    : rom_format;
    MEM_SIZE  : positive;
    SYNC_READ : boolean := true
  );
  port (
    Clock : in std_ulogic;
    Re    : in std_ulogic;
    Addr  : in natural range 0 to MEM_SIZE-1;
    Data  : out std_ulogic_vector
  );
end entity;

architecture rtl of rom is
  type rom_mem is array (0 to MEM_SIZE-1) of bit_vector(Data'length-1 downto 0);


  impure function read_hex_file(file_name : string; format : in rom_format) return rom_mem is
    -- Read a hex ROM file
    file fh       : text open read_mode is file_name;
    variable ln   : line;
    variable addr : natural := 0;
    variable word : std_logic_vector(Data'length-1 downto 0);
    variable rom  : rom_mem;

    procedure read_hex(ln : inout line; hex : out std_logic_vector) is
      -- The standard hread() procedure doesn't work well when the target bit vector
      -- is not a multiple of four. This wrapper provides better behavior.
      variable hex4 : std_logic_vector(((hex'length + 3) / 4) * 4 - 1 downto 0);
    begin
      hread(ln, hex4);
      -- Trim upper bits if the target is shorter than the nibble adjusted word
      hex := hex4(hex'length-1 downto 0);
    end procedure;

  begin

    while addr < MEM_SIZE loop
      if endfile(fh) then
        exit;
      end if;

      readline(fh, ln);

      if format = HEX_TEXT then
        read_hex(ln, word); -- Convert hex string to bits
      else -- Binary text
        read(ln, word);
      end if;
      rom(addr) := to_bitvector(word);

      addr := addr + 1;
    end loop;

    return rom;
  end function;


  signal rom_data : rom_mem := read_hex_file(ROM_FILE, FORMAT);

  signal sync_rdata : std_ulogic_vector(Data'range);
begin

  rd: process(Clock)
  begin
    if rising_edge(Clock) then
      if Re = '1' then
        sync_rdata <= to_stdulogicvector(rom_data(Addr));
      end if;
    end if;
  end process;

  Data <= to_stdulogicvector(rom_data(Addr)) when SYNC_READ = false else sync_rdata;

end architecture;



