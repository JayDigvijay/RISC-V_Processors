\m4_TLV_version 1d: tl-x.org
\SV
//  Instruction I is decoded as follows:
// op-location-data
// 1)I[65:64] = OpCode (00 => Read Instruction, 01 => Read Data, 11 => Write Data)
// 2)I[63:32] = Memory Location
// 3)I[31:0] = Data to be written, defined only for wd, else X 

   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   m4_define(M4_NUM_INSTRS, 6)
   m4_define(M4_NUM_LINES, 512) // As calculated in TL-Verilog_Cache.md
   m4_define(M4_NUM_WAYS, 4) // OpenPiton Specification
   bit [65:0] instructions [0:M4_NUM_INSTRS - 1];
	bit [149:0] dcache [0:M4_NUM_LINES - 1]; // 150 bits per line in Data Cache
   bit [276:0] icache [0:M4_NUM_LINES - 1]; // 277 bits per line in Instruction Cache
   bit [15:0] dcounter [0:M4_NUM_LINES - 1]; // 16-bit counter to help find LRU Data
   bit [15:0] icounter [0:M4_NUM_LINES - 1]; // 16-bit counter to help find LRU Instruction

	assign instructions = '{
   66'b0110101101010111101111101111010100XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,
   66'b0110101101110111101001101111010000XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,
   66'b0111011101010111101110101111011000XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,
   66'b0110101101010100101110001111011100XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,
   66'b111010110101011110111110111101010010111111101111111111111011100011,
   66'b0111101101010100100010001111010000XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   };

\TLV
   $reset = *reset;
   |cache
      @0    // Fetch and Decode Stage
         /fetch
            $reset = /top<>0$reset; // ***
            // =====
            // FETCH
            // =====
            $instr[65:0] = *instructions\[$pc[2:0]\];

         /decode
            // ======
            // DECODE
            // ======

            $opcode[1:0] = $instr[65:64];  
            $address[31:0] = $instr[63:32];
            $write = $opcode[1];      // 1 for Write operation, 0 for Read operation
            $dtype = $opcode[0];      // 1 if Data-type , 0 if Instruction-Type
            $itype = ~$dtype;
            ?$write
               $write_data[31:0] = $instr[31:0];
            ?$dtype
               $data_block_offset[1:0] = $address[3:2];
               $data_block_start[7:0] = $data_block_offset * 32;
               $data_tag[20:0] = $address[31:11];
            ?$itype
               $instr_block_offset[2:0] = $address[4:2];
               $instr_tag[19:0] = $address[31:12];
            $index[6:0] = $dtype == 1 ? $address[10:4] : $address[11:5];
         /search
            //=============
            //CACHE SEARCH
            //============= 
            $start[8:0] = $index[6:0] * 4;
            ?$dtype
               $d0[149:0] = *dcache\[$start[8:0]\];
               $d1[149:0] = *dcache\[$start[8:0] + 1\];
               $d2[149:0] = *dcache\[$start[8:0] + 2\];
               $d3[149:0] = *dcache\[$start[8:0] + 3\];
               $d_hit = (($d0[149] == 1) && ($data_tag == $d0[148:127]))
                    ||(($d1[149] == 1) && ($data_tag == $d1[148:127]))
                    ||(($d2[149] == 1) && ($data_tag == $d2[148:127]))
                    ||(($d3[149] == 1) && ($data_tag == $d3[148:127]));
               $d_miss = !$d_hit;
            ?$itype
               $i0[149:0] = *icache\[$start[8:0]\];
               $i1[149:0] = *icache\[$start[8:0] + 1\];
               $i2[149:0] = *icache\[$start[8:0] + 2\];
               $i3[149:0] = *icache\[$start[8:0] + 3\];
               $i_hit = (($i0[149] == 1) && ($instr_tag == $i0[148:127]))
                    ||(($i1[149] == 1) && ($instr_tag == $i1[148:127]))
                    ||(($i2[149] == 1) && ($instr_tag == $i2[148:127]))
                    ||(($i3[149] == 1) && ($instr_tag == $i3[148:127]));
               $i_miss = !$i_hit;
         /lru
            ?$dtype
               *dcounter\[$start[8:0]\] = (($d0[149] == 1) && ($data_tag == $d0[148:127])) ? 0 
                                          : (*dcounter\[$start[8:0]\] + 1);
               *dcounter\[$start[8:0] + 1\] = (($d1[149] == 1) && ($data_tag == $d1[148:127])) ? 0 
                                          : (*dcounter\[$start[8:0] + 1\] + 1);
               *dcounter\[$start[8:0] + 2\] = (($d2[149] == 1) && ($data_tag == $d2[148:127])) ? 0 
                                          : (*dcounter\[$start[8:0] + 2\] + 1);
               *dcounter\[$start[8:0] + 3\] = (($d3[149] == 1) && ($data_tag == $d3[148:127])) ? 0 
                                          : (*dcounter\[$start[8:0] + 3\] + 1);
                                          
            ?$itype
               *icounter\[$start[8:0]\] = (($i0[149] == 1) && ($instr_tag == $i0[148:127])) ? 0 
                                          : (*icounter\[$start[8:0]\] + 1);
               *icounter\[$start[8:0] + 1\] = (($i1[149] == 1) && ($instr_tag == $i1[148:127])) ? 0 
                                          : (*icounter\[$start[8:0] + 1\] + 1);
               *icounter\[$start[8:0] + 2\] = (($i2[149] == 1) && ($instr_tag == $i2[148:127])) ? 0 
                                          : (*icounter\[$start[8:0] + 2\] + 1);
               *icounter\[$start[8:0] + 3\] = (($i3[149] == 1) && ($instr_tag == $i3[148:127])) ? 0 
                                          : (*icounter\[$start[8:0] + 3\] + 1);
              
            
               
                  
               
               
                
         
      

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
