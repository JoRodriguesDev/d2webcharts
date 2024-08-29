unit uModel.Charts.Utils;

interface

uses
  uModel.Charts.Interfaces;

function ColorEnumToString(AColor: TChartColor; AOpacity: Double = 1.0): string;

implementation

uses
  System.SysUtils;

function ColorEnumToString(AColor: TChartColor; AOpacity: Double = 1.0): string;
begin
  case AColor of
    none:         Result  := 'rgba(222, 226, 230, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    blue:         Result  := 'rgba(13, 110, 253, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    indigo:       Result  := 'rgba(102, 16, 242, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    purple:       Result  := 'rgba(111, 66, 193, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    pink:         Result  := 'rgba(214, 51, 132, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    red:          Result  := 'rgba(220, 53, 69, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    orange:       Result  := 'rgba(253, 126, 20, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    yellow:       Result  := 'rgba(255, 193, 7, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    green:        Result  := 'rgba(25, 135, 84, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    teal:         Result  := 'rgba(32, 201, 151, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    cyan:         Result  := 'rgba(13, 202, 240, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    black:        Result  := 'rgba(0, 0, 0, '       + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    white:        Result  := 'rgba(255, 255, 255, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray:         Result  := 'rgba(108, 117, 125, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    graydark:     Result  := 'rgba(52, 58, 64, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray100:      Result  := 'rgba(248, 249, 250, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray200:      Result  := 'rgba(233, 236, 239, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray300:      Result  := 'rgba(222, 226, 230, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray400:      Result  := 'rgba(206, 212, 218, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray500:      Result  := 'rgba(173, 181, 189, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray600:      Result  := 'rgba(108, 117, 125, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray700:      Result  := 'rgba(73, 80, 87, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray800:      Result  := 'rgba(52, 58, 64, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    gray900:      Result  := 'rgba(33, 37, 41, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    primary:      Result  := 'rgba(13, 110, 253, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    secondary:    Result  := 'rgba(108, 117, 125, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    success:      Result  := 'rgba(25, 135, 84, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    info:         Result  := 'rgba(13, 202, 240, '  + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    warning:      Result  := 'rgba(255, 193, 7, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    danger:       Result  := 'rgba(220, 53, 69, '   + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    light:        Result  := 'rgba(248, 249, 250, ' + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    dark:         Result  := 'rgba(33, 37, 41, '    + StringReplace(FloatToStr(AOpacity), ',', '.', [rfReplaceAll]) + ')';
    transparent:  Result  := 'transparent';
  end;
end;

end.
