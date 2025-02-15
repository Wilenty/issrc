program Help4ISdevs;

{$AppType Console}

Uses
	SysUtils;

var
  CmdLineRaw: string;  
begin
  CmdLineRaw := CmdLine;
  Delete( CmdLineRaw, 1, Pos(' ', CmdLineRaw) );
  CmdLineRaw := Trim( CmdLineRaw );
	WriteLn( Format( 'The length of "%s" = %d', [CmdLineRaw, Length( CmdLineRaw )] ) );
  Readln;
end.
