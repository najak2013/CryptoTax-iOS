//
//  BarChartTestViewController.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/17.
//

import UIKit
import Charts

class BarChartTestViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var barChartView: BarChartView!
    var months: [String]!
    var unitsSold: [Double]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
    
        
        barChartView.delegate = self
        
        // x축  gride 노출(
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.enabled = true
        barChartView.xAxis.drawLabelsEnabled = true
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawAxisLineEnabled = false
        
        
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        
        
        
        barChartView.rightAxis.enabled = false
        
        
        
        barChartView.leftAxis.enabled = true
        

        // 경계선 활성화 여부
        barChartView.drawBordersEnabled = false
        // 데이터 범주 삭제
        barChartView.legend.form = .none
        barChartView.legend.enabled = false

        // 확대 안되게
        barChartView.scaleXEnabled = false
        barChartView.scaleYEnabled = false

        // 더블탭 확대 안되게
        barChartView.doubleTapToZoomEnabled = false
        
        
        let ll = ChartLimitLine(limit: 0.0, label: "")
        barChartView.leftAxis.addLimitLine(ll)
        
        
        unitsSold = [34, 100, -30, 0, 400, -100]
        testData(dataPoints: unitsSold, barValues: unitsSold)
        setData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    print(entry)
    }
    
    func setData() {
        let dataSet = BarChartDataSet(entries: barDataEntries, label: "")
//        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = true
        dataSet.valueFont = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.regular)
        // 차트 컬러
//        dataSet.colors = [.red]
//        dataSet.lineWidth = 3

//        dataSet.mode = .cubicBezier
        
        
//        dataSet.drawFilledEnabled = true
//        dataSet.fillColor = .red
//        dataSet.fillAlpha = 0.8

        // 선택했을 때 위치에 가로선, 세로선을 표시할 것인지
//        dataSet.drawHorizontalHighlightIndicatorEnabled = false
//        dataSet.drawVerticalHighlightIndicatorEnabled = true
        
//        dataSet.highlightColor = .systemRed
        
        
        let barChartData = BarChartData(dataSet: dataSet)
        barChartView.data = barChartData
    }
    
    
    
    var barDataEntries: [BarChartDataEntry] = []
    
    func testData(dataPoints: [Double], barValues: [Double]) {
        for i in 0 ..< dataPoints.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: barValues[i])
            barDataEntries.append(barDataEntry)
        }
    }
    
    

}
