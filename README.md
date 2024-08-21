# d2webgraph
Este repositório contém um conjunto de classes Delphi desenvolvido para gerar gráficos no formato HTML. Inicialmente criado para um projeto pessoal em [D2Bridge](https://www.d2bridge.com.br/), um framework que permite compilar projetos VCL ou FireMonkey para a Web com o mesmo código.

<p align="center">
	<img src="https://agiliza.click/charts.gif">
</p>


## Instalação
Instalação usando o boss
```
boss install https://github.com/JoRodriguesDev/d2webgraph
```

## Declaração
Para utilizar o d2webgraph você deve adicionar as uses:
```pascal
  uModel.Charts.Interfaces,
  uModel.Charts.Factory;
```

Declarar no head do html
```html
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
```

## Tipos
```
Bootstrap 5 Doughnut Chart
Bootstrap 5 Bar Chart
Bootstrap 5 Line Chart
Bootstrap 5 Pie Chart
Bootstrap 5 Polar Area Chart
Bootstrap 5 Radar Chart
```

## Como usar
```pascal
  var HTML := TModelChartFactory.New
                                .Line
                                .Height('150px')
                                .Width('300px')
                                  .AddChartDataSet('2023')
                                  .Opacity(0.8)
                                    .AddChartData('Janeiro', 50, TChartColor.primary, TChartColor.primary)
                                    .AddChartData('Fevereiro', 45, TChartColor.primary, TChartColor.primary)
                                    .AddChartData('Março', 70, TChartColor.primary, TChartColor.primary)
                                    .AddChartData('Abril', 75, TChartColor.primary, TChartColor.primary)
                                    .AddChartData('Maio', 90, TChartColor.primary, TChartColor.primary)
                                    .AddChartData('Junho', 30, TChartColor.primary, TChartColor.primary)
                                    .&end
                                  .AddChartDataSet('2024')
                                  .Opacity(0.5)
                                    .AddChartData('Janeiro', 55, TChartColor.success, TChartColor.success)
                                    .AddChartData('Fevereiro', 50, TChartColor.success, TChartColor.success)
                                    .AddChartData('Março', 82, TChartColor.success, TChartColor.success)
                                    .AddChartData('Abril', 79, TChartColor.success, TChartColor.success)
                                    .AddChartData('Maio', 80, TChartColor.success, TChartColor.success)
                                    .AddChartData('Junho', 42, TChartColor.success, TChartColor.success)
                                    .&end
                                .Generate;
```
