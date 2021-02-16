\m4_TLV_version 1d: tl-x.org
\SV
//  Instruction I is decoded as follows:
// op-location-data
// 1)I[65:64] = OpCode (00 => Read Instruction, 01 => Read Data, 11 => Write Data)
// 2)I[63:32] = Memory Location
// 3)I[31:0] = Data to be written, defined only for wd, else X 

   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   m4_define(M4_NUM_INSTRS, 6)
   logic [65:0] instructions [0:M4_NUM_INSTRS - 1];
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

            $instr = *instructions\[$pc[2:0]\];
         /decode
            // ======
            // DECODE
            // ======

            $opcode[1:0] = $instr[65:64];  
            $memloc[31:0] = $instr[63:32];
            $write = $opcode[1];       // 1 for Write operation, 0 for Read operation
            $dtype = $opcode[0];      // 1 if Data-type , 0 if Instruction-Type
            $itype = ~$dtype;
            ?$write
               $write_data[31:0] = $instr[31:0];
            ?$dtype
               $data_block_offset[1:0] = $memloc[3:2];
               $index[6:0] = $memloc[10:4];
               $data_tag[20:0] = $memloc[31:11];
            ?$itype
               $instr_block_offset[2:0] = $memloc[4:2];
               $index[6:0] = $memloc[11:5];
               $instr_tag[19:0] = $memloc[31:12];
         /search
            //=============
            //CACHE SEARCH
            //=============
         
      
      

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
