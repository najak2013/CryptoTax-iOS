//
//  ExchangeDetailsGraphTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/24.
//

import UIKit
import Charts

class ExchangeDetailsGraphTableViewCell: UITableViewCell, ChartViewDelegate {

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    @IBOutlet weak var barChartView: BarChartView!
    
    
    var months: [String]!
    var unitsSold: [Double]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
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
        barChartView.leftAxis.gridColor = .white

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
        ll.lineDashLengths = [3.0]
        ll.lineColor = UIColor(red: 0.8235, green: 0.8392, blue: 0.8588, alpha: 1.0)
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
        dataSet.colors = [UIColor(red: 0.898, green: 0.9098, blue: 0.9216, alpha: 1.0)]
        
        dataSet.highlightColor = UIColor(red: 0.3137, green: 0.3451, blue: 0.4, alpha: 1.0)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
