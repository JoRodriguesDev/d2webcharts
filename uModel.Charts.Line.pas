unit uModel.Charts.Line;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.Classes;

type
  TModelChartLine = class(TInterfacedObject, iModelChart)
  private
    FChartID: string;
    FChartDataSets: TInterfaceList;
    FHeight: string;
    FWidth: string;
    FLabel: string;
    FOnItemClick: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelChart;
    function AddChartDataSet(ALabel: string): iModelChartDataSet;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function Height(AValue: string): iModelChart;
    function DataSets(Index: Integer): iModelChartDataSet;
    function Width(AValue: string): iModelChart;
    function OnItemClick(ACallbackJS: string): iModelChart;
    function Generate: string;
    function Update: string;
  end;

implementation

uses
  System.SysUtils,
  uModel.Charts.Data,
  uModel.Charts.Utils,
  uModel.Charts.DataSet;

{ TModelChartLine }

function TModelChartLine.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartLine.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FChartID := 'chartjs-line' + IntToStr(Random(MaxInt));
  FHeight := '150px';
  FWidth  := '400px';
end;

function TModelChartLine.DataSets(Index: Integer): iModelChartDataSet;
begin
  result := FChartDataSets.Items[Index] as iModelChartDataSet;
end;

destructor TModelChartLine.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartLine.AddChartDataSet(ALabel: string): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel);
  FChartDataSets.Add(Result);
end;

function TModelChartLine.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartLine.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartLine.LabelName: string;
begin
  Result := FLabel;
end;

function TModelChartLine.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

class function TModelChartLine.New: iModelChart;
begin
  Result := Self.Create;
end;

function TModelChartLine.OnItemClick(ACallbackJS: string): iModelChart;
begin
  Result := Self;
  FOnItemClick := ACallbackJS;
end;

function TModelChartLine.Update: string;
begin
  var LDataSetUpdateStr := '';
  var LLabelsUpdateStr  := '';

  for var i := 0 to FChartDataSets.Count - 1 do
  begin
    var LChartDataSet   := (FChartDataSets[i] as iModelChartDataSet);
    var LDatasetsStr    := LChartDataSet.ArrayValues;
    var LDatasetLabels  := LChartDataSet.GenerateLabels;

    LDataSetUpdateStr := LDataSetUpdateStr + Format('chart.data.datasets[%d].data = %s;', [i, LDatasetsStr]);
    LLabelsUpdateStr  := LLabelsUpdateStr + Format('chart.data.labels = [%s];', [i, LDatasetLabels]);
  end;

  Result :=
    'var chart = Chart.getChart("'+ FChartID +'");' +
    'if (chart) {' +
    '  ' + LLabelsUpdateStr +
    '  ' + LDataSetUpdateStr +
    '  chart.update();' +
    '}';
end;

function TModelChartLine.Generate: string;
var
  LLabelsStr, LDatasetsStr: string;
  LChartDataSet: iModelChartDataSet;
begin
  LLabelsStr    := EmptyStr;
  LDatasetsStr  := EmptyStr;

  LLabelsStr    := (FChartDataSets[0] as iModelChartDataSet).GenerateLabels;

  for var i := 0 to Pred(FChartDataSets.Count) do
  begin
    LChartDataSet := (FChartDataSets[i] as iModelChartDataSet);
    if i > 0 then
      LDatasetsStr  := LDatasetsStr + ', ';
    LDatasetsStr  := LDatasetsStr + LChartDataSet.Generate;
  end;

  Result := Format(
    '<canvas id="' + FChartID + '" width="%s" height="%s"></canvas>' +
    '<script>' +
    'document.addEventListener("DOMContentLoaded", () => {' +
    '  const ctx = document.getElementById("'+ FChartID +'").getContext("2d");' +
    '  const chart = new Chart(ctx, {' +
    '    type: "line",' +
    '    data: {' +
    '      labels: [%s],' +
    '      datasets: [%s]' +
    '    },' +
    '    options: {' +
    '      responsive: true,' +
    '      scales: {' +
    '        x: {' +
    '          grid: {' +
    '            offset: true' +
    '          }' +
    '        },' +
    '        y: {' +
    '          beginAtZero: true' +
    '        }' +
    '      },' +
    '    onClick: (e) => {' +
    '      const activePoints = chart.getElementsAtEventForMode(e, "nearest", { intersect: false }, false);' +
    '      if (activePoints.length > 0) {' +
    '        const index = activePoints[0].index;' +
    '        const datasetIndex = activePoints[0].datasetIndex;' +
    '        const label = chart.data.labels[index];' +
    '        const datasetLabel = chart.data.datasets[datasetIndex].label;' +
    '        const value = chart.data.datasets[datasetIndex].data[index];' +
            FOnItemClick +
    '      }' +
    '    }' +
    '    }' +
    '  });' +
    '});' +
    '</script>', [FWidth, FHeight, LLabelsStr, LDatasetsStr]);
end;

end.
