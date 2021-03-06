{

USAGE:

The idea behind these attributes is quite simple: most should
generally only need display to be used with grids.
It is possible, however, that some fields may need more
hints, such as those which should really be a memo instead of a
string, so a DataField one is provided too.
The others can be sprinkled liberally except (of course) for the
primary key one.
}
unit ARLibs.RTTI.DatasetBuilder.Attributes;

interface

uses DB;

Type

  DisplayAttribute = class( TCustomAttribute )
  private
    FColumnLabel: String;
    function GetVisible: Boolean;
    procedure SetColumnLabel(const Value: String);
  public
    constructor Create( AColumnLabel: String = 'None' );
    property ColumnLabel: String read FColumnLabel write SetColumnLabel;
    property Visible: Boolean read GetVisible;
  end;

  NoDisplayAttribute = class( DisplayAttribute )
  public
  constructor Create;
  end;

  DataFieldAttribute = class(TCustomAttribute)
  private
    FDataType: TFieldType;
    FSize: Integer;
    FPrecision: Integer;
    FName: String;
    procedure SetDataType(const Value: TFieldType);
    procedure SetSize(const Value: Integer);
    procedure SetPrecision(const Value: Integer);
    procedure SetName(const Value: String);
  public
    constructor Create( AName: String;ADataType: TFieldType;ASize: Integer;APrecision: Integer );
    property Name: String read FName write SetName;
    property DataType: TFieldType read FDataType write SetDataType;
    property Size: Integer read FSize write SetSize;
    property Precision: Integer read FPrecision write SetPrecision;
  end;

  PrimaryKeyAttribute = class( TCustomAttribute )
  public
  end;

  UniqueValuesAttribute = class( TCustomAttribute )
  public
  end;

  RequiredAttribute = class( TCustomAttribute )
  public
  end;

  // This is used to exclude a property from being translated into a field
  ExcludeAttribute = class( TCustomAttribute )
  public
  end;

implementation

uses SysUtils;

{ TDisplayAttribute }

constructor DisplayAttribute.Create(AColumnLabel: String);
begin
  inherited Create;
  FColumnLabel := AColumnLabel;
end;

function DisplayAttribute.GetVisible: Boolean;
var LabelNotEmpty : Boolean;
    LabelIsNone : Boolean;
begin
  LabelNotEmpty := ColumnLabel.IsEmpty = False;
  LabelIsNone := SameText( ColumnLabel,'None' );
  Result := LabelNotEmpty and Not LabelIsNone;
end;

procedure DisplayAttribute.SetColumnLabel(const Value: String);
begin
  FColumnLabel := Value;
end;

{ DataFieldAttribute }

constructor DataFieldAttribute.Create(AName: String;ADataType: TFieldType; ASize,
  APrecision: Integer);
begin
  inherited Create;
  FName := AName;
  FDataType := ADataType;
  FSize := ASize;
  FPrecision := APrecision;
end;

procedure DataFieldAttribute.SetDataType(const Value: TFieldType);
begin
  FDataType := Value;
end;

procedure DataFieldAttribute.SetName(const Value: String);
begin
  FName := Value;
end;

procedure DataFieldAttribute.SetPrecision(const Value: Integer);
begin
  FPrecision := Value;
end;

procedure DataFieldAttribute.SetSize(const Value: Integer);
begin
  FSize := Value;
end;

{ NoDisplayAttribute }

constructor NoDisplayAttribute.Create;
begin
  inherited Create( 'None' );
end;

end.
