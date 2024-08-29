unit uModel.Charts.Radar;

interface

uses
  System.Generics.Collections,
  System.Variants,
  uModel.Charts.Interfaces,
  System.Classes;

type
  TModelChartRadar = class(TInterfacedObject, iModelChart)
  private
    FChartID: string;
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

{ TModelChartRadar }

function TModelChartRadar.ClearDataSets: iModelChart;
begin
  FChartDataSets.Clear;
  Result := Self;
end;

constructor TModelChartRadar.Create;
begin
  inherited Create;
  FChartDataSets := TInterfaceList.Create;
  FChartID := 'chartjs-radar' + IntToStr(Random(MaxInt));
  FHeight := '150px';
  FWidth  := '400px';
end;

function TModelChartRadar.DataSets(Index: Integer): iModelChartDataSet;
begin
  result := FChartDataSets.Items[Index] as iModelChartDataSet;
end;

destructor TModelChartRadar.Destroy;
begin
  FChartDataSets.Free;
  inherited Destroy;
end;

function TModelChartRadar.AddChartDataSet(ALabel: string): iModelChartDataSet;
begin
  Result := TModelChartDataSet.New(Self, ALabel);
  FChartDataSets.Add(Result);
end;

function TModelChartRadar.Height(AValue: string): iModelChart;
begin
  FHeight := AValue;
  Result := Self;
end;

function TModelChartRadar.LabelName(AValue: string): iModelChart;
begin
  result := self;
  FLabel := AValue;
end;

function TModelChartRadar.LabelName: string;
begin
  Result := FLabel;
end;

function TModelChartRadar.Width(AValue: string): iModelChart;
begin
  FWidth := AValue;
  Result := Self;
end;

class function TModelChartRadar.New: iModelChart;
begin
  Result := Self.Create;
end;

function TModelChartRadar.Update: string;
begin
  var LDataSetUpdateStr := '';
  for var i := 0 to FChartDataSets.Count - 1 do
  begin
    var LDatasetsStr := (FChartDataSets[i] as iModelChartDataSet).ArrayValues;
    LDataSetUpdateStr := LDataSetUpdateStr + Format('chart.data.datasets[%d].data = %s;', [i, LDatasetsStr]);
  end;

  Result :=
    'var chart = Chart.getChart("'+ FChartID +'");' +
    'if (chart) {' +
    ' ' + LDataSetUpdateStr + ' ' +
    '  chart.update();' +
    '}';
end;

function TModelChartRadar.Generate: string;
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
    '<canvas id="chartjs-radar'+ FChartID +'" width="%s" height="%s"></canvas>' +
    '<script>' +
    'document.addEventListener("DOMContentLoaded", () => {' +
    '  new Chart(document.getElementById("chartjs-radar' + FChartID + '"), {' +
    '    type: "radar",' +
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

