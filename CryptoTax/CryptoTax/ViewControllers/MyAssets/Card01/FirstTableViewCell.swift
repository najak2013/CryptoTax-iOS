//
//  FirstTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/16.
//

import UIKit
import Charts
import TinyConstraints

class FirstTableViewCell: UITableViewCell, ChartViewDelegate {
    
    
    @IBOutlet weak var graphView: UIView!
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        
        
        chartView.noDataText = "데이터가 없습니다."
        chartView.noDataFont = .systemFont(ofSize: 20)
        chartView.noDataTextColor = .lightGray
    
        // x축  gride 노출(
        chartView.xAxis.drawGridLinesEnabled = false

        chartView.xAxis.drawLabelsEnabled = false
        
        chartView.xAxis.drawAxisLineEnabled = false
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false

        // 경계선 활성화 여부
        chartView.drawBordersEnabled = false

        // 데이터 범주 삭제
        chartView.legend.form = .none
        chartView.legend.enabled = false

        // 확대 안되게
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false

        // 더블탭 확대 안되게
        chartView.doubleTapToZoomEnabled = false
        return chartView
    }()
    
    
    var months: [String]!
    var unitsSold: [Double]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        graphView.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: graphView)
        lineChartView.height(to: graphView)
        lineChartView.delegate = self
        
        
//        months = ["Jan", "Feb", "Mar", "Jan", "Feb", "Mar", "Jan", "Feb", "Mar", "Jan"]
        unitsSold = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 7, 8, 9, -10, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -1, 2, 3, 4, 1, 2, 3, 4, 5, 6, 7, -8, 9, 10, 5, 6, 7, 8, 9, 10]
        testData(dataPoints: unitsSold, lineValues: unitsSold)
        
        setData()
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    print(entry)
    }
    
    func setData() {
        let dataSet = LineChartDataSet(entries: lineDataEntries, label: "")
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        // 차트 컬러
        dataSet.colors = [.red]
        dataSet.lineWidth = 3

        dataSet.mode = .cubicBezier
        
        
//        dataSet.drawFilledEnabled = true
//        dataSet.fillColor = .red
//        dataSet.fillAlpha = 0.8

        // 선택했을 때 위치에 가로선, 세로선을 표시할 것인지
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = true
        
        dataSet.highlightColor = .systemRed
        
        
        let lineChartData = LineChartData(dataSet: dataSet)
        lineChartView.data = lineChartData
    }
    
    
    
    var lineDataEntries: [ChartDataEntry] = []
    
    func testData(dataPoints: [Double], lineValues: [Double]) {
        for i in 0 ..< dataPoints.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: lineValues[i])
            lineDataEntries.append(lineDataEntry)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
