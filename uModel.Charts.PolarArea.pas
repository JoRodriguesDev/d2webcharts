unit uModel.Charts.PolarArea;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.Classes;

type
  TModelChartPolarArea = class(TInterfacedObject, iModelChart)
  private
    FChartDataSets: TInterfaceList;
    FHeight: string;
    FWidth: string;
    FLabel: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelChart;
    function AddChartDataSet(ALabel: string): iModelChartDataSet;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function NewId: iModelChart;
    function DataSets(Index: Integer): iModelChartDataSet;
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
    function Update: string;
  end;

implementation

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

{ TModelChartPolarArea }

function TModelChartPolarArea.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartPolarArea.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

function TModelChartPolarArea.DataSets(Index: Integer): iModelChartDataSet;
begin
  result := FChartDataSets.Items[Index] as iModelChartDataSet;
end;

destructor TModelChartPolarArea.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartPolarArea.AddChartDataSet(ALabel: string): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel);
  FChartDataSets.Add(Result);
end;

function TModelChartPolarArea.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartPolarArea.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartPolarArea.LabelName: string;
begin
  Result := FLabel;
end;

function TModelChartPolarArea.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

class function TModelChartPolarArea.New: iModelChart;
begin
  Result := Self.Create;
end;

function TModelChartPolarArea.NewId: iModelChart;
begin

end;

function TModelChartPolarArea.Update: string;
begin

end;

function TModelChartPolarArea.Generate: string;
var
  LLabelsStr, LDatasetsStr, LChartID: string;
  LChartDataSet: iModelChartDataSet;
begin
  LLabelsStr    := EmptyStr;
  LDatasetsStr  := EmptyStr;
  LChartID      := EmptyStr;
  LLabelsStr    := (FChartDataSets[0] as iModelChartDataSet).GenerateLabels;
  LChartID      := IntToStr(Random(MaxInt));
  for var i := 0 to Pred(FChartDataSets.Count) do
  begin
    LChartDataSet := (FChartDataSets[i] as iModelChartDataSet);
    if i > 0 then
      LDatasetsStr  := LDatasetsStr + ', ';
    LDatasetsStr  := LDatasetsStr + LChartDataSet.Generate;
  end;

  Result := Format(
    '<canvas id="chartjs-polar-area'+ LChartID +'" width="%s" height="%s"></canvas>' +
    '<script>' +
    'document.addEventListener("DOMContentLoaded", () => {' +
    '  new Chart(document.getElementById("chartjs-polar-area' + LChartID + '"), {' +
    '    type: "polarArea",' +
    '    data: {' +
    '      labels: [%s],' +
    '      datasets: [%s]' +
    '    }' +
    '  });' +
    '});' +
    '</script>',
    [FWidth, FHeight, LLabelsStr, LDatasetsStr]);
end;

end.
