unit uModel.Charts.Doughnut;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.Classes;

type
  TModelChartDoughnut = class(TInterfacedObject, iModelChart)
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

{ TModelChartDoughnut }

function TModelChartDoughnut.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartDoughnut.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FHeight := '150px';
  FWidth  := '400px';
end;

destructor TModelChartDoughnut.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartDoughnut.AddChartDataSet(ALabel: string): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel);
  FChartDataSets.Add(Result);
end;

function TModelChartDoughnut.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartDoughnut.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartDoughnut.LabelName: string;
begin
  Result := FLabel;
end;

function TModelChartDoughnut.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

class function TModelChartDoughnut.New: iModelChart;
begin
  Result := Self.Create;
end;

function TModelChartDoughnut.Generate: string;
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
    '<canvas id="chartjs-doughnut'+ LChartID +'" width="%s" height="%s"></canvas>' +
    '<script>' +
    'document.addEventListener("DOMContentLoaded", () => {' +
    '  new Chart(document.getElementById("chartjs-doughnut' + LChartID + '"), {' +
    '    type: "doughnut",' +
    '    data: {' +
    '      labels: [%s],' +
    '      datasets: [%s]' +
    '    },' +
    '    options: {' +
    '              maintainAspectRatio: false' +
    '            }' +
    '          });' +
    '        });' +
    '    </script>', [FWidth, FHeight, LLabelsStr, LDatasetsStr]);
end;

end.

