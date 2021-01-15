/* ----------------------------------------------------------------------------------------------------------------------

PS-FPGA Licenses (DUAL License GPLv2 and commercial license)

This PS-FPGA source code is copyright © 2019 Romain PIQUOIS and licensed under the GNU General Public License v2.0, 
 and a commercial licensing option.
If you wish to use the source code from PS-FPGA, email laxer3a [at] hotmail [dot] com for commercial licensing.

See LICENSE file.
---------------------------------------------------------------------------------------------------------------------- */

module LeadCountS32(
	input [31:0]	value,
	output [5:0]	result
);
	reg [5:0] oneLead;
	reg [5:0] zeroLead;
	wire[30:0] valueI = value[31] ? ~value[30:0] : value[30:0];
	
	// BRUTE FORCE REFERENCE
	/* 
	always @ (value)
	casez(value)
		32'b00000000_00000000_00000000_00000001: zeroLead = 6'd31;
		32'b00000000_00000000_00000000_0000001?: zeroLead = 6'd30;
		32'b00000000_00000000_00000000_000001??: zeroLead = 6'd29;
		32'b00000000_00000000_00000000_00001???: zeroLead = 6'd28;
		32'b00000000_00000000_00000000_0001????: zeroLead = 6'd27;
		32'b00000000_00000000_00000000_001?????: zeroLead = 6'd26;
		32'b00000000_00000000_00000000_01??????: zeroLead = 6'd25;
		32'b00000000_00000000_00000000_1???????: zeroLead = 6'd24;
		32'b00000000_00000000_00000001_????????: zeroLead = 6'd23;
		32'b00000000_00000000_0000001?_????????: zeroLead = 6'd22;
		32'b00000000_00000000_000001??_????????: zeroLead = 6'd21;
		32'b00000000_00000000_00001???_????????: zeroLead = 6'd20;
		32'b00000000_00000000_0001????_????????: zeroLead = 6'd19;
		32'b00000000_00000000_001?????_????????: zeroLead = 6'd18;
		32'b00000000_00000000_01??????_????????: zeroLead = 6'd17;
		32'b00000000_00000000_1???????_????????: zeroLead = 6'd16;
		32'b00000000_00000001_????????_????????: zeroLead = 6'd15;
		32'b00000000_0000001?_????????_????????: zeroLead = 6'd14;
		32'b00000000_000001??_????????_????????: zeroLead = 6'd13;
		32'b00000000_00001???_????????_????????: zeroLead = 6'd12;
		32'b00000000_0001????_????????_????????: zeroLead = 6'd11;
		32'b00000000_001?????_????????_????????: zeroLead = 6'd10;
		32'b00000000_01??????_????????_????????: zeroLead = 6'd9;
		32'b00000000_1???????_????????_????????: zeroLead = 6'd8;
		32'b00000001_????????_????????_????????: zeroLead = 6'd7;
		32'b0000001?_????????_????????_????????: zeroLead = 6'd6;
		32'b000001??_????????_????????_????????: zeroLead = 6'd5;
		32'b00001???_????????_????????_????????: zeroLead = 6'd4;
		32'b0001????_????????_????????_????????: zeroLead = 6'd3;
		32'b001?????_????????_????????_????????: zeroLead = 6'd2;
		32'b01??????_????????_????????_????????: zeroLead = 6'd1;
		32'b1???????_????????_????????_????????: zeroLead = 6'd0;
		default                               : zeroLead = 6'd32;
	endcase

	always @ (value)
	casez(value)
		32'b11111111_11111111_11111111_11111110: oneLead = 6'd31;
		32'b11111111_11111111_11111111_1111110?: oneLead = 6'd31;
		32'b11111111_11111111_11111111_111110??: oneLead = 6'd29;
		32'b11111111_11111111_11111111_11110???: oneLead = 6'd28;
		32'b11111111_11111111_11111111_1110????: oneLead = 6'd27;
		32'b11111111_11111111_11111111_110?????: oneLead = 6'd26;
		32'b11111111_11111111_11111111_10??????: oneLead = 6'd25;
		32'b11111111_11111111_11111111_0???????: oneLead = 6'd24;
		32'b11111111_11111111_11111110_????????: oneLead = 6'd23;
		32'b11111111_11111111_1111110?_????????: oneLead = 6'd22;
		32'b11111111_11111111_111110??_????????: oneLead = 6'd21;
		32'b11111111_11111111_11110???_????????: oneLead = 6'd21;
		32'b11111111_11111111_1110????_????????: oneLead = 6'd19;
		32'b11111111_11111111_110?????_????????: oneLead = 6'd18;
		32'b11111111_11111111_10??????_????????: oneLead = 6'd17;
		32'b11111111_11111111_0???????_????????: oneLead = 6'd16;
		32'b11111111_11111110_????????_????????: oneLead = 6'd15;
		32'b11111111_1111110?_????????_????????: oneLead = 6'd14;
		32'b11111111_111110??_????????_????????: oneLead = 6'd13;
		32'b11111111_11110???_????????_????????: oneLead = 6'd12;
		32'b11111111_1110????_????????_????????: oneLead = 6'd11;
		32'b11111111_110?????_????????_????????: oneLead = 6'd11;
		32'b11111111_10??????_????????_????????: oneLead = 6'd9;
		32'b11111111_0???????_????????_????????: oneLead = 6'd8;
		32'b11111110_????????_????????_????????: oneLead = 6'd7;
		32'b1111110?_????????_????????_????????: oneLead = 6'd6;
		32'b111110??_????????_????????_????????: oneLead = 6'd5;
		32'b11110???_????????_????????_????????: oneLead = 6'd4;
		32'b1110????_????????_????????_????????: oneLead = 6'd3;
		32'b110?????_????????_????????_????????: oneLead = 6'd2;
		32'b10??????_????????_????????_????????: oneLead = 6'd1;
		32'b0???????_????????_????????_????????: oneLead = 6'd1;
		default                               : oneLead = 6'd32;
	endcase
	*/

	//-----------------------------------------------
	//  Count Leading zero computation
	//-----------------------------------------------
	// Probably a bit smaller than a 16 bit priority encoder.
	// Faster too.
	reg [2:0] countT3,countT2,countT1,countT0;
	
	always @ (valueI)
	casez(valueI[30:24]) // Number of leading zero for [31:24]
		7'b0000001: countT3 = 3'b111;
		7'b000001?: countT3 = 3'b110;
		7'b00001??: countT3 = 3'b101;
		7'b0001???: countT3 = 3'b100;
		7'b001????: countT3 = 3'b011;
		7'b01?????: countT3 = 3'b010;
		7'b1??????: countT3 = 3'b001;
		default   : countT3 = 3'b000; // Dont care value
	endcase
	wire anyOneT3 = |valueI[30:24];

	always @ (valueI)
	casez(valueI[23:16]) // Number of leading zero for [23:16]
		8'b00000001: countT2 = 3'b111;
		8'b0000001?: countT2 = 3'b110;
		8'b000001??: countT2 = 3'b101;
		8'b00001???: countT2 = 3'b100;
		8'b0001????: countT2 = 3'b011;
		8'b001?????: countT2 = 3'b010;
		8'b01??????: countT2 = 3'b001;
		8'b1???????: countT2 = 3'b000;
		default    : countT2 = 3'b000; // Dont care value
	endcase
	wire anyOneT2 = |valueI[23:16];

	always @ (valueI)
	casez(valueI[15:8]) // Number of leading zero for [15: 8]
		8'b00000001: countT1 = 3'b111;
		8'b0000001?: countT1 = 3'b110;
		8'b000001??: countT1 = 3'b101;
		8'b00001???: countT1 = 3'b100;
		8'b0001????: countT1 = 3'b011;
		8'b001?????: countT1 = 3'b010;
		8'b01??????: countT1 = 3'b001;
		8'b1???????: countT1 = 3'b000;
		default    : countT1 = 3'b000; // Dont care value
	endcase
	wire anyOneT1 = |valueI[15:8];

	always @ (valueI)
	casez(valueI[7:0]) // Number of leading zero for [ 7: 0]
		8'b00000001: countT0 = 3'b111;
		8'b0000001?: countT0 = 3'b110;
		8'b000001??: countT0 = 3'b101;
		8'b00001???: countT0 = 3'b100;
		8'b0001????: countT0 = 3'b011;
		8'b001?????: countT0 = 3'b010;
		8'b01??????: countT0 = 3'b001;
		8'b1???????: countT0 = 3'b000;
		default    : countT0 = 3'b000; // Dont care value
	endcase
	wire anyOneT0 = |valueI[7:0];

	// Gather all leading zero generated in parallel and generate final value.
	always @ (*)
	begin
		if (anyOneT3)
			zeroLead = { 3'b000 , countT3 };
		else
		begin
			if (anyOneT2)
				zeroLead = { 3'b001, countT2 };
			else
			begin
				if (anyOneT1)
					zeroLead = { 3'b010, countT1 };
				else
				begin
					if (anyOneT0)
						zeroLead = { 3'b011, countT0 };
					else
						zeroLead = 6'd32;
				end
			end
		end
	end

/*
	//-----------------------------------------------
	//  Count Leading One computation
	//-----------------------------------------------
	reg [2:0] countO3,countO2,countO1,countO0;
	
	always @ (value)
	casez(value[31:24]) // Number of leading one for [31:24]
		8'b11111110: countO3 = 3'b111;
		8'b1111110?: countO3 = 3'b110;
		8'b111110??: countO3 = 3'b101;
		8'b11110???: countO3 = 3'b100;
		8'b1110????: countO3 = 3'b011;
		8'b110?????: countO3 = 3'b010;
		8'b10??????: countO3 = 3'b001;
		8'b0???????: countO3 = 3'b000;
		default    : countO3 = 3'b000; // Dont care value
	endcase
	wire anyZeroO3 = !(&value[31:24]);

	always @ (value)
	casez(value[23:16]) // Number of leading one for [23:16]
		8'b11111110: countO2 = 3'b111;
		8'b1111110?: countO2 = 3'b110;
		8'b111110??: countO2 = 3'b101;
		8'b11110???: countO2 = 3'b100;
		8'b1110????: countO2 = 3'b011;
		8'b110?????: countO2 = 3'b010;
		8'b10??????: countO2 = 3'b001;
		8'b0???????: countO2 = 3'b000;
		default    : countO2 = 3'b000; // Dont care value
	endcase
	wire anyZeroO2 = !(&value[23:16]);

	always @ (value)
	casez(value[15:8]) // Number of leading one for [15: 8]
		8'b11111110: countO1 = 3'b111;
		8'b1111110?: countO1 = 3'b110;
		8'b111110??: countO1 = 3'b101;
		8'b11110???: countO1 = 3'b100;
		8'b1110????: countO1 = 3'b011;
		8'b110?????: countO1 = 3'b010;
		8'b10??????: countO1 = 3'b001;
		8'b0???????: countO1 = 3'b000;
		default    : countO1 = 3'b000; // Dont care value
	endcase
	wire anyZeroO1 = !(&value[15:8]);

	always @ (value)
	casez(value[7:0]) // Number of leading one for [ 7: 0]
		8'b11111110: countO0 = 3'b111;
		8'b1111110?: countO0 = 3'b110;
		8'b111110??: countO0 = 3'b101;
		8'b11110???: countO0 = 3'b100;
		8'b1110????: countO0 = 3'b011;
		8'b110?????: countO0 = 3'b010;
		8'b10??????: countO0 = 3'b001;
		8'b0???????: countO0 = 3'b000;
		default    : countO0 = 3'b000; // Dont care value
	endcase
	wire anyZeroO0 = !(&value[7:0]);

	// Gather all leading zero generated in parallel and generate final value.
	always @ (*)
	begin
		if (anyZeroO3)
			oneLead = { 3'b000 ,countO3 };
		else
		begin
			if (anyZeroO2)
				oneLead = { 3'b001, countO2 };
			else
			begin
				if (anyZeroO1)
					oneLead = { 3'b010, countO1 };
				else
				begin
					if (anyZeroO0)
						oneLead = { 3'b011, countO0 };
					else
						oneLead = 6'd32;
				end
			end
		end
	end

	assign result = value[31] ? oneLead : zeroLead;
*/
	assign result = zeroLead;
endmodule
