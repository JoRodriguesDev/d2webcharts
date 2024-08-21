unit uModel.Charts.Interfaces;

interface

uses
  System.Classes;

type
  EnumColor = (
    none, blue, indigo,
    purple, pink ,red,
    orange, yellow, green,
    teal, cyan, black,
    white, gray, graydark,
    gray100, gray200, gray300,
    gray400, gray500, gray600,
    gray700, gray800, gray900,
    primary, secondary, success,
    info, warning, danger,
    light, dark, transparent);

  TChartColor = EnumColor;

type
  iModelChartData = interface;
  iModelChartDataSet = interface;
  iModelChart = interface;

  iModelChartData = interface
    ['{8E128234-A31F-422D-9001-00D12883C4E5}']
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

  iModelChartDataSet = interface
    ['{A1234567-89AB-CDEF-0123-456789ABCDEF}']
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

  iModelChart = interface
    ['{C9BD1133-7A8F-42A9-A2C9-950251F8177A}']
    function AddChartDataSet(ALabel: string): iModelChartDataSet;
    function LabelName: string; overload;
    function LabelName(AValue: string): iModelChart; overload;
    function ClearDataSets: iModelChart;
    function Height(AValue: string): iModelChart;
    function Width(AValue: string): iModelChart;
    function Generate: string;
  end;

  iModelChartFactory = interface
    ['{AABB99D5-B5A5-4F99-B2AF-332E27B66172}']
    function Bar: iModelChart;
    function Line: iModelChart;
    function Pie: iModelChart;
    function Doughnut: iModelChart;
    function PolarArea: iModelChart;
    function Radar: iModelChart;
  end;

implementation

end.

