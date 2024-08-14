// https://groups.google.com/g/innosetup/c/XRqmCxUtlE4/m/EOkCd3OKBAAJ

[Setup]
AppName=FileCopyAlernative-TFileStream
AppVersion=1.0
AppPublisher=Krystian Bigaj
OutputBaseFilename=FileCopyAlernative-TFileStream
CreateAppDir=no
Uninstallable=no

[code]
function FileCopyWithTFileStream(ASrc, ADest: String): Boolean;
var
  lSrc, lDest: TFileStream;
  lSize: Longint;
begin
  Result := True;
  try
    lSrc:= TFileStream.Create(ASrc, fmOpenRead or fmShareDenyNone);
    try
      lDest:= TFileStream.Create(ADest, fmCreate);
      try
        lSize := lSrc.Size;
#If ver >= 0x06040000
        lDest.CopyFrom(lSrc, lSize, lSize);
#Else
        lDest.CopyFrom(lSrc, lSize);
#EndIf
      finally
        lDest.Free;
      end;
    finally
      lSrc.Free;
    end;
  except
    Log('FileCopyWithTFileStream failed. Exception=' + GetExceptionMessage);
    Result := False;
  end;
end;

Function InitializeSetup: Boolean;
  begin
// https://github.com/jrsoftware/issrc/blob/is-5_6_1/Projects/ScriptFunc_R.pas#L544
// https://github.com/jrsoftware/issrc/blob/is-6_0_5/Projects/ScriptFunc_R.pas#L531
// https://github.com/jrsoftware/issrc/blob/is-6_2_2/Projects/ScriptFunc_R.pas#L581
// https://github.com/jrsoftware/issrc/blob/is-6_3_3/Projects/Src/ScriptFunc_R.pas#L556
//    FileCopy( ExpandConstant('{srcexe}'), ExpandConstant('{srcexe}')+'.1', False );

    FileCopyAlernative( ExpandConstant('{srcexe}'), ExpandConstant('{srcexe}')+'.1' );
end;
