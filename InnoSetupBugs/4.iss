; This script it's written correctly, but it not works - I showed it as a bad example!
; So, don't use the same names of the Functions/Procedures in your code
; as the same name from Classes of the Parameters/Functions/Procedures/etc....
;
; Probability that someone will do it is very rare, but it can happens...
[Setup]
AppName=Create function error because of the TObject.Create constructor
AppVersion=ALL
DefaultDirName={src}\Create-Function
AppPublisher=Wilenty
OutputBaseFilename=Create-Function
Uninstallable=no
OutputDir=.

[Components]
; You will not see the Component "test Create" in the Installer,
; because of the "TOnject.Create" constructor...
Name: "test_Create"; Description: "test Create"; Check: "Create";

[Files]
; below file will not be installed, because of missing Component: "test_Create"...
Source: "compiler:default.isl"; DestDir: "{app}"; Components: "test_Create";

[code]
Function Create: Boolean;
  begin
    // You will not see the MsgBox below, insetad you will see an error...
    Result := MsgBox('Function Create: Boolean;', mbInformation, MB_OK) = IDOK;
end;

Function InitializeSetup: Boolean;
  var
    myObject: TObject;
  begin
    Result := True;
    Try
      myObject := TObject.Create;
    except
      Result := False;
    end;
    myObject.Free;
end;
