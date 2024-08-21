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
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
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
  FHeight := '150px';
  FWidth  := '400px';
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

function TModelChartLine.Generate: string;
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
    '<canvas id="chartjs-line'+ LChartID +'" width="%s" height="%s"></canvas>' +
    '<script>' +
    'document.addEventListener("DOMContentLoaded", () => {' +
    '  new Chart(document.getElementById("chartjs-line' + LChartID + '"), {' +
    '    type: "line",' +
    '    data: {' +
    '      labels: [%s],' +
    '      datasets: [%s]' +
    '    },' +
    '    options: {' +
    '      scales: {' +
    '        xAxes: [{' +
    '          reverse: true,' +
    '          gridLines: {' +
    '            color: "rgba(0,0,0,0.05)"' +
    '          }' +
    '        }],' +
    '        yAxes: [{' +
    '          borderDash: [5, 5],' +
    '          gridLines: {' +
    '            color: "rgba(0,0,0,0)",' +
    '            fontColor: "#fff"' +
    '          }' +
    '        }]' +
    '      }' +
    '    }' +
    '  });' +
    '});' +
    '</script>', [FWidth, FHeight, LLabelsStr, LDatasetsStr]);
end;

end.

