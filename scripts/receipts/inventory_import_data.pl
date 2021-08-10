inventoryImport('007432600012').

%% computeChecksum(UPC,UPCWithChecksumDigit) :-
%% 	findall(Result,
%% 		(
%% 		 between(0,9,X),
%% 		 concat_atom(['eancheck ',UPC,X],Command),
%% 		 p(Command),
%% 		 shell_command_to_string(Command,'Check digit correct\n'),
%% 		 concat_atom([UPC,X],Result)
%% 		),
%% 		[UPCWithChecksumDigit]).

computeChecksum(UPC,UPCWithChecksumDigit) :-
	concat_atom(['./checksum.pl "',UPC,'"'],Command),
	shell_command_to_string(Command,UPCWithChecksumDigit).

lookupInventory :-
	inventoryImport(Barcode),
	concat_atom(['0',Tmp],Barcode),
	p(Tmp),
	computeChecksum(Tmp,NewBarcode),
	p(NewBarcode),
	atom_number(NewBarcode,Number),
	once((
	      lookup_branded_food_by_barcode(Number,FDC_ID,DESC),
	      p(FDC_ID),
	      p(DESC)
	     )),
	%% once(food_nutrition_by_fdc_id(FDC_ID,_)),
	fail.
lookupInventory.