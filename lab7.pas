uses crt;
type
  Tlist = ^list1;
  list1 = record
    next: Tlist;
    number: integer;  
  end;
  a=array[0..9] of Tlist;
  b=array [1..100] of integer;
var table,head:a;
    num,k,elem:integer;
    ich:char;
    mas:b;
    file1:file of integer;

procedure createfile(var n:integer);
var i,digit:integer;
begin 
  writeln('введите числа:');
  for i:=1 to n do
  begin 
    readln(digit);
    write(file1,digit);
  end;
end;

procedure createtable(var k1:integer; var tabl,head1:a{;file1:file of integer});
var chislo,i,raz:integer;
begin
  reset(file1);
  for i:=0 to 9 do
  begin
    new(tabl[i]);
    tabl[i]^.number:=0;
    head1[i]:=tabl[i];
    tabl[i]^.next:=nil;
  end;
  while not eof(file1) do
  begin
  read(file1,chislo);
  raz:=chislo;
  if k1=1 then raz:=chislo mod 10 
  else
  begin
    for i:=1 to k1-1 do
    raz:=raz div 10;
    raz:=raz mod 10;
  end;  
  new(tabl[raz]^.next);
  tabl[raz]:=tabl[raz]^.next;
  tabl[raz]^.number:=chislo;
  tabl[raz]^.next:=nil;
  end;
  writeln;
end;

procedure qsort(first,last:integer;var mas2:b);
var left,right,c,mid: integer;
begin
  if first < last then
  begin
    mid:= mas2[(first + last) div 2];
    left:= first;
    right:= last;
    while left <= right do
    begin
      while mas2[left] < mid do inc(left);                 
      while mas2[right] > mid do dec(right);                 
      if left <= right then
      begin
        c:= mas2[left];
        mas2[left]:= mas2[right];
        mas2[right]:= c;
        inc(left);
        dec(right);
      end;
    end;
    qsort(first, right,mas2);  
    qsort(left, last,mas2);
  end;
end;
 
procedure sorting(var tabl,head1:a ;var mas1:b);
var mas:b;
    dx,x:a;
    i,count,j:integer;
begin
  for i:=0 to 9 do
  begin
    tabl[i]:=head[i];
    count:=0;
    if tabl[i]^.next<>nil then
    begin
    tabl[i]:=tabl[i]^.next;
    while tabl[i]<>nil do
    begin
      inc(count);
      mas1[count]:=tabl[i]^.number;
      tabl[i]:=tabl[i]^.next;
    end;
    tabl[i]:=head[i];
    while tabl[i]<> nil do
    begin
      dx[i]:=tabl[i];
      dx[i]:=tabl[i]^.next;
      dispose(tabl[i]);
    end;
    qsort(1,count,mas1);
    new(tabl[i]);
    tabl[i]^.number:=0;
    head1[i]:=tabl[i];
    tabl[i]^.next:=nil;
    for j:=1 to count do
    begin
      new(tabl[i]^.next);
      tabl[i]:=tabl[i]^.next;
      tabl[i]^.number:=mas1[j];
      tabl[i]^.next:=nil;
    end;
    end;
  end;  
end;

procedure show(var tabl,head1:a);
var i:integer;
begin
  for i:=0 to 9 do
  begin
    tabl[i]:=head1[i];
    if tabl[i]^.next <> nil then
    begin
      tabl[i]:=tabl[i]^.next;
      write(i,' ');
      while tabl[i]<>nil do
      begin
        write(tabl[i]^.number,' ');
        tabl[i]:=tabl[i]^.next;
      end;writeln;
    end;   
  end;
end;

procedure add(var element,k1:integer; var tabl,head1:a);
var raz,i:integer;
begin
  if k1=1 then raz:=element mod 10 
  else
  begin
    raz:=element;
    for i:=1 to k1-1 do
    raz:=raz div 10;
    raz:=raz mod 10;
  end;  
  tabl[raz]:=head1[raz];
  while tabl[raz]^.next<>nil do
  tabl[raz]:=tabl[raz]^.next;
  new(tabl[raz]^.next);
  tabl[raz]:=tabl[raz]^.next;
  tabl[raz]^.number:=element;
  tabl[raz]^.next:=nil;
end;

begin
  clrscr;
  assign(file1,'d:\text.txt');
  rewrite(file1);  
  writeln('введите количество чисел');
  readln(num);
  createfile(num);
  writeln('введите разряд');
  readln(k);
  createtable(k,table,head);
  sorting(table,head,mas);
  show(table,head);
  repeat
      writeln('1 - добавить элемент');
      writeln('2 - изменить список');
      writeln('3 - изменить разряд');
      writeln('4 - выход');
      writeln;
      ich:=readkey;
      case ich of
        '1': begin
                clrscr;
                readln(elem);
                write(file1,elem);
                add(elem,k,table,head);
                sorting(table,head,mas);
                show(table,head);
                readkey;
             end;
        '2': begin
                clrscr;
                close(file1);
                rewrite(file1);
                reset(file1);
                writeln('введите количество чисел');
                readln(num);
                createfile(num);
                writeln('введите разряд');
                readln(k);
                createtable(k,table,head);
                sorting(table,head,mas);
                show(table,head);                
                readkey;
             end;
        '3': begin
                clrscr;
                writeln('введите разряд');
                readln(k);
                createtable(k,table,head);
                sorting(table,head,mas);
                show(table,head);
                readkey;
             end;
        end;
        until ich='4';
    writeln;
    close(file1);
end.
        
        
                       
                
                
                
      
