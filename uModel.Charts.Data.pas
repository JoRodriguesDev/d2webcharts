unit uModel.Charts.Data;

interface

uses
  uModel.Charts.Interfaces;

type
  TModelChartData = class(TInterfacedObject, iModelChartData)
  private
    FLabelName: string;
    FValue: Variant;
    FBackgroundColor: TChartColor;
    FBorderColor: TChartColor;
    FPointBackgroundColor: TChartColor;
    FPointBorderColor: TChartColor;
    FPointHoverBackgroundColor: TChartColor;
    FPointHoverBorderColor: TChartColor;
  public
    constructor Create(const ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor: TChartColor);
    class function New(const ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor: TChartColor): iModelChartData;
    destructor Destroy; override;
    function LabelName(AValue: string): iModelChartData; overload;
    function Value(AValue: Variant): iModelChartData; overload;
    function BackgroundColor(AValue: TChartColor): iModelChartData; overload;
    function BorderColor(AValue: TChartColor): iModelChartData; overload;
    function PointBackgroundColor(AValue: TChartColor): iModelChartData; overload;
    function PointBorderColor(AValue: TChartColor): iModelChartData; overload;
    function PointHoverBackgroundColor(AValue: TChartColor): iModelChartData; overload;
    function PointHoverBorderColor(AValue: TChartColor): iModelChartData; overload;
    function LabelName: string; overload;
    function Value: Variant; overload;
    function BackgroundColor: TChartColor; overload;
    function BorderColor: TChartColor; overload;
    function PointBackgroundColor: TChartColor; overload;
    function PointBorderColor: TChartColor; overload;
    function PointHoverBackgroundColor: TChartColor; overload;
    function PointHoverBorderColor: TChartColor; overload;
  end;

implementation

{ TChartData }

function TModelChartData.BorderColor: TChartColor;
begin
  result := FBorderColor;
end;

function TModelChartData.BorderColor(AValue: TChartColor): iModelChartData;
begin
  result := Self;
  FBorderColor := AValue;
end;

function TModelChartData.BackgroundColor(AValue: TChartColor): iModelChartData;
begin
  result := Self;
  FBackgroundColor := AValue;
end;

function TModelChartData.BackgroundColor: TChartColor;
begin
  Result := FBackgroundColor;
end;

constructor TModelChartData.Create(const ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor: TChartColor);
begin
  FLabelName                  := ALabel;
  FValue                      := AValue;
  FBackgroundColor            := ABackgroundColor;
  FBorderColor                := ABorderColor;
  FPointBackgroundColor       := APointBackgroundColor;
  FPointBorderColor           := APointBorderColor;
  FPointHoverBackgroundColor  := APointHoverBackgroundColor;
  FPointHoverBorderColor      := APointHoverBorderColor;
end;

destructor TModelChartData.Destroy;
begin

  inherited;
end;

function TModelChartData.LabelName: string;
begin
  Result := FLabelName;
end;

function TModelChartData.LabelName(AValue: string): iModelChartData;
begin
  result := Self;
  FLabelName := AValue;
end;

class function TModelChartData.New(const ALabel: string; AValue: Variant; ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor: TChartColor): iModelChartData;
begin
  result := self.Create(ALabel, AValue, ABackgroundColor, ABorderColor, APointBackgroundColor, APointBorderColor, APointHoverBackgroundColor, APointHoverBorderColor);
end;

function TModelChartData.PointBackgroundColor(AValue: TChartColor): iModelChartData;
begin
  result := Self;
  FPointBackgroundColor := AValue;
end;

function TModelChartData.PointBackgroundColor: TChartColor;
begin
  Result := FPointBackgroundColor;
end;

function TModelChartData.PointBorderColor: TChartColor;
begin
  Result := FPointBorderColor;
end;

function TModelChartData.PointBorderColor(AValue: TChartColor): iModelChartData;
begin
  result := Self;
  FPointBorderColor := AValue;
end;

function TModelChartData.PointHoverBackgroundColor(AValue: TChartColor): iModelChartData;
begin
  result := Self;
  FPointHoverBackgroundColor := AValue;
end;

function TModelChartData.PointHoverBackgroundColor: TChartColor;
begin
  Result := FPointHoverBackgroundColor;
end;

function TModelChartData.PointHoverBorderColor(AValue: TChartColor): iModelChartData;
begin
  result := Self;
  FPointHoverBorderColor := AValue;
end;

function TModelChartData.PointHoverBorderColor: TChartColor;
begin
  Result := FPointHoverBorderColor;
end;

function TModelChartData.Value(AValue: Variant): iModelChartData;
begin
  result := Self;
  FValue := AVAlue;
end;

function TModelChartData.Value: Variant;
begin
  result := FValue;
end;

end.
