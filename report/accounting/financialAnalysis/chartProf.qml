import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

import "components" 1.0
import "charts" 1.0

BasePage {
   id: root
   title: qsTr("Financial Statement Analysis")

   ColumnLayout {
      anchors.fill: parent

      ScrollView {
         id: scrollView
         clip: true
         Layout.fillWidth: true
         Layout.fillHeight: true

         ColumnLayout {
            width: Math.max(implicitWidth, scrollView.availableWidth)
            Layout.fillHeight: true

            Text {
               text: qsTr("Profitability index variation")
               font.pixelSize: Stylesheet.titleFontSize
               Layout.bottomMargin: Stylesheet.defaultMargin
               Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            StyledChartProf {
               id: mainChart
               height: availableHeight
               width: availableWidth
               Layout.fillWidth: true
               Layout.fillHeight: true

               function loadData() {
                  showLoadingIndicator(true)

                  chartOptions.legend.display = true;
                  chartOptions.legend.position = 'bottom';

                  var financialStatementAnalysis = new FinancialStatementAnalysis(Banana.document);
                  //Recovery of current settings.
                  var savedParam =Banana.document.getScriptSettings("financialStatementAnalysis");
                  if (savedParam.length > 0) {
                     var param = JSON.parse(savedParam);
                     financialStatementAnalysis.setParam(param);
                  }
                  financialStatementAnalysis.loadData();
                  var yearList = [];
                  var data = {};
                  data.roe = {};
                  data.roi = {};
                  data.ros = {};
                  data.mol = {};
                  data.ebm = {};
                  data.mon = {};
                  for (var i = 0; i < financialStatementAnalysis.data.length; i++) {
                     var periodo = financialStatementAnalysis.data[i].period.StartDate;
                      //for dont cut the Budget string in Budg.
                     var elementType = financialStatementAnalysis.data[i].period.Type;
                     if (elementType === "Y") {
                      periodo = periodo.substr(0, 4);
                     }
                     var year= periodo;
                     if (year.length>0 && yearList.indexOf(year)<0)
                        yearList.push(year);
                     data.roe[year] = financialStatementAnalysis.data[i].index.red.roe.amount;
                     data.roi[year] = financialStatementAnalysis.data[i].index.red.roi.amount;
                     data.ros[year] = financialStatementAnalysis.data[i].index.red.ros.amount;
                     data.mol[year] = financialStatementAnalysis.data[i].index.red.mol.amount;
                     data.ebm[year] = financialStatementAnalysis.data[i].index.red.ebm.amount;
                     data.mon[year] = financialStatementAnalysis.data[i].index.red.mon.amount;
                  }
                  for (var i = 0; i < yearList.length; i++) {
                     var year = yearList[i];
                     chartData.datasets[i] = {};
                     chartData.datasets[i].label = year;
                     var defaultColor = defaultColors[0].fill;
                     if (i < defaultColors.length)
                        defaultColor = defaultColors[i].fill;
                     chartData.datasets[i].backgroundColor = defaultColor;
                     chartData.datasets[i].data = [];
                     chartData.datasets[i].data.push(data.roe[year]);
                     chartData.datasets[i].data.push(data.roi[year]);
                     chartData.datasets[i].data.push(data.ros[year]);
                     chartData.datasets[i].data.push(data.mol[year]);
                     chartData.datasets[i].data.push(data.ebm[year]);
                     chartData.datasets[i].data.push(data.mon[year]);
                  }
                  repaintChart();
                  showLoadingIndicator(false)
               }

            }

            Item {
                height: 9
            }

         }
      }

      RowLayout {
         Layout.topMargin: Stylesheet.defaultMargin

         Item {
            Layout.fillWidth: true
         }
      }
   }

   Component.onCompleted: {
      loadData();

   }

   function loadData(){
     mainChart.loadData();
   }

}