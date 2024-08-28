unit uModel.Charts.Factory;

interface

uses
  System.Generics.Collections,
  uModel.Charts.Interfaces;

type
  TModelChartFactory = class(TInterfacedObject, iModelChartFactory)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelChartFactory ;
    function Bar: iModelChart;
    function Line: iModelChart;
    function Pie: iModelChart;
    function Doughnut: iModelChart;
    function PolarArea: iModelChart;
    function Radar: iModelChart;
  end;

implementation

uses
  uModel.Charts.Bar,
  uModel.Charts.Line,
  uModel.Charts.Pie,
  uModel.Charts.Doughnut,
  uModel.Charts.PolarArea,
  uModel.Charts.Radar;

{ TModelChartFactory }

const
  cHeight = '160px';
  cWidth = '500px';

function TModelChartFactory.Bar: iModelChart;
begin
  result := TModelChartBar.New.Height(cHeight).Width(cWidth);
end;

constructor TModelChartFactory.Create;
begin

end;

destructor TModelChartFactory.Destroy;
begin
  inherited;
end;

function TModelChartFactory.Doughnut: iModelChart;
begin
  result := TModelChartDoughnut.New.Height(cHeight).Width(cWidth);
end;

function TModelChartFactory.Line: iModelChart;
begin
  result := TModelChartLine.New.Height(cHeight).Width(cWidth);
end;

class function TModelChartFactory.New: iModelChartFactory ;
begin
  Result := Self.Create;
end;

function TModelChartFactory.Pie: iModelChart;
begin
  result := TModelChartPie.New.Height(cHeight).Width(cWidth);
end;

function TModelChartFactory.PolarArea: iModelChart;
begin
  result := TModelChartPolarArea.New.Height(cHeight).Width(cWidth);
end;

function TModelChartFactory.Radar: iModelChart;
begin
  result := TModelChartRadar.New.Height(cHeight).Width(cWidth);
end;

end.
