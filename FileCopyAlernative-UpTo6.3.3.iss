; Example created by Wilenty: https://wilenty.wixsite.com/links
; I don't agree to post anywhere any part of my example without above link!

[Setup]
AppName=FileCopyAlernative
AppVersion=1.0
AppPublisher=Wilenty
OutputBaseFilename=FileCopyAlernative
CreateAppDir=no
Uninstallable=no

[code]
function FileCopyAlernative( ASrc, ADest: String; FailIfExists: Boolean ): Boolean;
var
  CurPath, SrcPath, SrcFile: String;
begin
  CurPath := GetCurrentDir;
  SrcPath := ExtractFilePath( ASrc );
  SrcFile := ExtractFileName( ASrc );
  SetCurrentDir( SrcPath );
  Result := FileCopy( SrcFile, ADest, FailIfExists );
  SetCurrentDir( CurPath );
end;

Function InitializeSetup: Boolean;
  begin
// https://github.com/jrsoftware/issrc/blob/is-5_6_1/Projects/ScriptFunc_R.pas#L544
// https://github.com/jrsoftware/issrc/blob/is-6_0_5/Projects/ScriptFunc_R.pas#L531
// https://github.com/jrsoftware/issrc/blob/is-6_2_2/Projects/ScriptFunc_R.pas#L581
// https://github.com/jrsoftware/issrc/blob/is-6_3_3/Projects/Src/ScriptFunc_R.pas#L556
//    FileCopy( ExpandConstant('{srcexe}'), ExpandConstant('{srcexe}')+'.1', False );

    FileCopyAlernative( ExpandConstant('{srcexe}'), ExpandConstant('{srcexe}')+'.1', False );
end;
