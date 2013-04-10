function CommaFormatted(amount)
{
	var delimiter = ","; // replace comma if desired
	amount = new String(amount);
	var a = amount.split('.',2)
	var d = a[1];
	var i = parseInt(a[0]);
	if(isNaN(i)) { return ''; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	var n = new String(i);
	var a = [];
	while(n.length > 3)
	{
		var nn = n.substr(n.length-3);
		a.unshift(nn);
		n = n.substr(0,n.length-3);
	}
	if(n.length > 0) { a.unshift(n); }
	n = a.join(delimiter);
	if(d.length < 1) { amount = n; }
	else { amount = n + '.' + d; }
	amount = minus + amount;
	return amount;
}
function CurrencyFormatted(amount)
{
	amount = amount.replace(/,/g,"")
  var i = parseFloat(amount);
	if(isNaN(i)) { i = 0.00; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	i = parseInt((i + .005) * 100);
	i = i / 100;
	s = new String(i);
	if(s.indexOf('.') < 0) { s += '.00'; }
	if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
	s = minus + s;
	return s;
}
function tax_calulate(amount){
children = 4;
    a = amount*0.8
    tax = 0;
    if ( a > 5000){
     a = a - 5000
     if ( a > 2500*children){
      a = a - 2500*children
      if ( a > 30000){
       a = a - 30000
       if ( a > 30000 ){
        tax = 1500;
        a = a - 30000;
        if ( a > 30000 ){
         tax = 4500;
         a = a - 30000;
         if ( a > 50000 ){
          tax = 12000;
          a = a - 50000;
          if ( a > 50000 ){
           tax = 22000;
           a = a - 50000;
           tax = tax + a*0.25;
          }else{
           tax = tax + a*0.2;
          }
         }else{
          tax = tax + a*0.15;
         }
        }else{
         tax = tax + a*0.1;
        }
       }else{
        tax = tax + a*0.05;
       }
      }
     }
    }
    return tax;
}
