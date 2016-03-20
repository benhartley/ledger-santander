# Import Santander transaction data into Ledger

## Intro
This is an awk script to parse the TXT format export data from a Santander bank account (tested with UK data only, not sure it applies to other countries...) and output it in `ledger` format.

## Example input

Exported transaction data in the TXT format looks something like this:

```
From: 01/03/2016 to 02/03/2016
							
Account: XXXX XXXX XXXX XXXX
						
Date: 02/03/2016
Description: DIRECT DEBIT PAYMENT TO HAM
Amount: -6.00 	
Balance: 24.00
						
Date: 01/03/2016
Description:  FASTER PAYMENTS RECEIPT REF.CHEESE
Amount: 12.00 	
Balance: 30.00
```

## Example output

``` ledger
2016-03-02  DIRECT DEBIT TO HAM
 	santander  -£6.00 = £24.00
 	REPLACE

2016-03-01  FASTER PAYMENTS RECEIPT REF.CHEESE
 	santander  £12.00 = £30.00
 	REPLACE
```

## Usage
You may want to edit the variables defined at the top of the file to specify the ledger name/alias for the Santander account, the currency symbol and the string for the balancing account placeholder. The default values for these are as follows:

``` awk
account = "santander";
replace = "REPLACE";
symbol = "£";
```

Then export your data and run it though the awk script to get the ledger output. For some reason, data I export from Santander typically has `LATIN1` encoding and masses of trailing spaces, so I generally use this script as follows:

``` bash
iconv -f LATIN1 -t UTF-8 exported-data.txt \
| tr -d '\015' \
| sed -r -e 's/^\s+$$//g' \
| awk -f santander.awk \
>> data.ledger
```

