//
//  FirstTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/16.
//

import UIKit
import Charts
import TinyConstraints

class GraphTableViewCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet weak var totalAssetLabel: UILabel!
    @IBOutlet weak var revenueAmountLabel: UILabel!
    
    @IBOutlet weak var toggleSwitchView: UIView!
    @IBOutlet weak var toggleLeading: NSLayoutConstraint!
    @IBOutlet weak var toggleView: UIView!
    
    @IBOutlet var toggleButtons: [UIButton]!
    
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
        
        
        toggleSwitchView.layer.cornerRadius = toggleSwitchView.layer.frame.height / 2
        toggleSwitchView.clipsToBounds = true
        
        
        toggleView.layer.cornerRadius = toggleView.layer.frame.height / 2
//        toggleView.clipsToBounds = true
        toggleView.layer.masksToBounds = false
        toggleView.layer.shadowOpacity = 0.2
        toggleView.layer.shadowOffset = CGSize(width: 0, height: 0)
        toggleView.layer.shadowRadius = 2
        
        
        graphView.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: graphView)
        lineChartView.height(to: graphView)
        lineChartView.delegate = self
        
        
//        months = ["Jan", "Feb", "Mar", "Jan", "Feb", "Mar", "Jan", "Feb", "Mar", "Jan"]
        unitsSold = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 7, 8, 9, 5, 5, 6, 7, 10, 15, 10, 13, 13, 14, 19, 20, 22, 25, 20, 20, 23, 25, 25, 24, 23, 22, 20, 19, 20, 21, 20, 40, 41, 38, 40, 39, 41, 9, 10]
        testData(dataPoints: unitsSold, lineValues: unitsSold)
        
        setData()
        
        for button in toggleButtons {
            button.addTarget(self, action: #selector(toggleButtonAction), for: .touchUpInside)
            print(button.frame.width)
        }
        
    }
    
    @objc func toggleButtonAction(_ sender: UIButton) {
        print(sender.tag)
        
        
        toggleLeading.constant = sender.frame.width * CGFloat(sender.tag)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
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
