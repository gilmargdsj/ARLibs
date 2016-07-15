unit RTTIDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ARLibs.RTTI.Interfaces;

type
  TForm1 = class(TForm)
    memoProperties: TMemo;
    PropertyNamesBtn: TButton;
    ForEachBtn: TButton;
    procedure memoPropertiesChange(Sender: TObject);
    procedure PropertyNamesBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ForEachBtnClick(Sender: TObject);
  private
    { Private declarations }
    FPropertyHandler : IRttiPropertyHandler;
    procedure AddPropertyDetails( AName: String;AProperty: IRttiProperty );
  public
    { Public declarations }
  end;

  TMyClass = class
  private
    FMyString: String;
    FMyInt: Integer;
    procedure SetMyInt(const Value: Integer);
    procedure SetMyString(const Value: String);
  private
  public
    property MyInt: Integer read FMyInt write SetMyInt;
    property MyString: String read FMyString write SetMyString;
  end;

var
  Form1: TForm1;

implementation

uses ARLibs.RTTI.Core, System.Rtti;

{$R *.dfm}

procedure TForm1.PropertyNamesBtnClick(Sender: TObject);
var List: TStringList;
begin
  List := TStringList.Create;
  FPropertyHandler.Examine( TMyClass );
  FPropertyHandler.FillPropertyNames( List );
  memoProperties.Lines.AddStrings( List );
  List.Free;
end;

procedure TForm1.AddPropertyDetails(AName: String; AProperty: IRttiProperty);
begin
  memoProperties.Lines.Add( AName + ' - ' + AProperty.TypeName );
end;

procedure TForm1.ForEachBtnClick(Sender: TObject);
begin
  FPropertyHandler.Examine( TMyClass );
  memoProperties.Lines.BeginUpdate;
  memoProperties.Lines.Clear;
  FPropertyHandler.ForEach( procedure(AName: String; AProperty: IRttiProperty)
                            begin
                              memoProperties.Lines.Add( AName + ' - ' + AProperty.TypeName );
                            end, AlwaysInclude );
  memoProperties.Lines.EndUpdate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPropertyHandler := TRttiPropertyHandlerImpl.Create( TRttiContext.Create );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FPropertyHandler := nil;
end;

procedure TForm1.memoPropertiesChange(Sender: TObject);
begin

end;

{ TMyClass }

procedure TMyClass.SetMyInt(const Value: Integer);
begin
  FMyInt := Value;
end;

procedure TMyClass.SetMyString(const Value: String);
begin
  FMyString := Value;
end;

end.
