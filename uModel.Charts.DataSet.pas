unit uModel.Charts.DataSet;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.Classes;

type
  TModelChartDataSet = class(TInterfacedObject, iModelChartDataSet)
  private
    [weak]
    FParent: iModelChart;
    FChartDataList: TInterfaceList;
    FOpacity: Double;
    FLabel: string;
    function GenerateBackgroundColors: string;
    function GenerateBorderColors: string;
    function GenerateValue: string;
    function GeneratePointBackgroundColor: string;
  public
    constructor Create(AParent: iModelChart; ALabel: string);
    class function New(AParent: iModelChart; ALabel: string): iModelChartDataSet;
    destructor Destroy; override;
    function GenerateLabels: string;
    function AddChartData(ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor: TChartColor; APointBackgroundColor: TChartColor = None; APointBorderColor: TChartColor = None; APointHoverBackgroundColor: TChartColor = None; APointHoverBorderColor: TChartColor = None): iModelChartDataSet;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChartDataSet; overload;
    function Opacity(AValue: Double): iModelChartDataSet; overload;
    function Generate: string;
    function Opacity: Double; overload;
    function RecordCount: integer;
    function &End: iModelChart;
  end;

implementation

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils;

{ TModelChartDataSet }

constructor TModelChartDataSet.Create(AParent: iModelChart; ALabel: string);
begin
  FParent := AParent;
  FChartDataList := TInterfaceList.Create;
  FLabel := ALabel;
  FOpacity := 1;
end;

destructor TModelChartDataSet.Destroy;
begin
  FChartDataList.Free;
  inherited Destroy;
end;

function TModelChartDataSet.&End: iModelChart;
begin
  result := FParent;
end;

function TModelChartDataSet.AddChartData(ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor: TChartColor; APointBackgroundColor: TChartColor = None; APointBorderColor: TChartColor = None; APointHoverBackgroundColor: TChartColor = None; APointHoverBorderColor: TChartColor = None): iModelChartDataSet;
begin
  Result := Self;
  var ChartData := TModelChartData.New(ALabel, AValue, ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor);
  FChartDataList.Add(ChartData);
end;

function TModelChartDataSet.GenerateValue: string;
begin
  var DataStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    DataStr := DataStr + VarToStr(ChartData.Value);
    if I < FChartDataList.Count - 1 then
      DataStr := DataStr + ', ';
  end;
  Result := DataStr;
end;

function TModelChartDataSet.GenerateLabels: string;
begin
  var DataStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    DataStr := DataStr + '"' + VarToStr(ChartData.LabelName) + '"';
    if I < FChartDataList.Count - 1 then
      DataStr := DataStr + ', ';
  end;
  Result := DataStr;
end;

function TModelChartDataSet.LabelName(AValue: string): iModelChartDataSet;
begin
  result := Self;
  FLabel := AValue;
end;

function TModelChartDataSet.LabelName: string;
begin
  Result := FLabel;
end;

class function TModelChartDataSet.New(AParent: iModelChart; ALabel: string): iModelChartDataSet;
begin
  Result := self.Create(AParent, Alabel);
end;

function TModelChartDataSet.Opacity: Double;
begin
  result := FOpacity;
end;

function TModelChartDataSet.Opacity(AValue: Double): iModelChartDataSet;
begin
  result := self;
  FOpacity := AValue;
end;

function TModelChartDataSet.RecordCount: integer;
begin
  Result := FChartDataList.Count;
end;

function TModelChartDataSet.GenerateBackgroundColors: string;
begin
  var ColorsStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    ColorsStr := ColorsStr + '"' + ColorEnumToString(ChartData.BackgroundColor, FOpacity) + '"';
    if I < FChartDataList.Count - 1 then
      ColorsStr := ColorsStr + ', ';
  end;
  Result := ColorsStr;
end;

function TModelChartDataSet.GeneratePointBackgroundColor: string;
begin
  var BackgroundColorStr := EmptyStr;
  if FChartDataList.Count > 0 then
  begin
    var ChartData := FChartDataList[0] as iModelChartData;  
    BackgroundColorStr := '"' + ColorEnumToString(ChartData.PointBackgroundColor, FOpacity) + '"';
  end;
  Result := BackgroundColorStr;
end;

function TModelChartDataSet.GenerateBorderColors: string;
begin
  var ColorsStr := EmptyStr;
  for var I := 0 to FChartDataList.Count - 1 do
  begin
    var ChartData := FChartDataList[I] as iModelChartData;
    ColorsStr := ColorsStr + '"' + ColorEnumToString(ChartData.BorderColor, FOpacity) + '"';
    if I < FChartDataList.Count - 1 then
      ColorsStr := ColorsStr + ', ';
  end;
  Result := ColorsStr;
end;

function TModelChartDataSet.Generate: string;
var
  LPointBackgroundColorStr, LPointBorderColorStr, LPointHoverBackgroundColorStr, LPointHoverBorderColorStr: string;
begin
  var LPointBackgroundColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointBackgroundColor <> Default(TChartColor) then
      LPointBackgroundColorStr := Format('pointBackgroundColor: "%s",', [ColorEnumToString(LPointBackgroundColor, FOpacity)])
  else LPointBackgroundColorStr := '';

  var LPointBorderColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointBorderColor <> Default(TChartColor) then
      LPointBorderColorStr := Format('pointBorderColor: "%s",', [ColorEnumToString(LPointBorderColor, FOpacity)])
  else LPointBorderColorStr := '';

  var LPointHoverBackgroundColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointHoverBackgroundColor <> Default(TChartColor) then
      LPointHoverBackgroundColorStr := Format('pointHoverBackgroundColor: "%s",', [ColorEnumToString(LPointHoverBackgroundColor, FOpacity)])
  else LPointHoverBackgroundColorStr := '';

  var LPointHoverBorderColor := (FChartDataList[0] as iModelChartData).PointBackgroundColor;
  if LPointHoverBorderColor <> Default(TChartColor) then
      LPointHoverBorderColorStr := Format('pointHoverBorderColor: "%s",', [ColorEnumToString(LPointHoverBorderColor, FOpacity)])
  else LPointHoverBorderColorStr := '';

  Result := Format(
    '{' +
    '   label: "%s",' +
    '   fill: true,' +
    '   backgroundColor: [%s],' +
    '   borderColor: [%s],' +
    '   %s' +
    '   %s' +
    '   %s' +
    '   %s' +
    '   data: [%s]' +
    '}', [self.LabelName, self.GenerateBackgroundColors, self.GenerateBorderColors,
          LPointBackgroundColorStr, LPointBorderColorStr, LPointHoverBackgroundColorStr,
          LPointHoverBorderColorStr, Self.GenerateValue]);
end;

end.

