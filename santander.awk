BEGIN {
    RS = "" ;
    FS = "\n";
    account = "santander";
    replace = "REPLACE";
    symbol = "£";
}

{
	match($1, /Date:[^0-9]*([0-9]*)\/([0-9]*)\/([0-9]*)/, date)
	match($2, /Description:[^a-zA-Z0-9]*(.*)$/, payee)
	match($3, /Amount:[^-0-9.]*([-0-9.]*)/, amount)
	match($4, /Balance:[^-0-9.]*([-0-9.]*)/, balance)
	if (date[3])
	{
		print date[3] "-" date[2] "-" date[1] "  " payee[1]
		print " 	" account  symbol amount[1] " = "symbol balance[1]
		print " 	" replace
		print ""
	}
}
