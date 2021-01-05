//
//  GraphView.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 24/12/2020.
//

import UIKit
import Charts

struct DummyGraphData {
    let date: String
    let rate: Double
}

class GraphView: UIView {
    
    let dummyData = [DummyGraphData(date: "2020-10-19", rate: 9148.61), DummyGraphData(date: "2020-10-20", rate: 13868.01), DummyGraphData(date: "2020-10-21", rate: 24872.84), DummyGraphData(date: "2020-10-22", rate: 26073.66), DummyGraphData(date: "2020-10-23", rate: 17146.98), DummyGraphData(date: "2020-10-26", rate: 17628.37), DummyGraphData(date: "2020-10-27", rate: 1765.75), DummyGraphData(date: "2020-10-28", rate: 4824.44), DummyGraphData(date: "2020-10-29", rate: 883.08), DummyGraphData(date: "2020-10-30", rate: 19192.02), DummyGraphData(date: "2020-11-02", rate: 50622.18), DummyGraphData(date: "2020-11-02", rate: 50622.18), DummyGraphData(date: "2020-11-03", rate: 50568.06), DummyGraphData(date: "2020-11-04", rate: 39054.38), DummyGraphData(date: "2020-11-05", rate: 31795.59), DummyGraphData(date: "2020-11-06", rate: 73234.34), DummyGraphData(date: "2020-11-09", rate: 29391.93), DummyGraphData(date: "2020-11-10", rate: 37044.78), DummyGraphData(date: "2020-11-11", rate: 36399.55), DummyGraphData(date: "2020-11-12", rate: 49595.65), DummyGraphData(date: "2020-11-13", rate: 54156.04), DummyGraphData(date: "2020-11-16", rate: 48727.86), DummyGraphData(date: "2020-11-17", rate: 69688.61), DummyGraphData(date: "2020-11-18", rate: 57707.39)]
    
    let tabView = CustomTabView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let emailAlertLabelLabel: UILabel = {
        let label = UILabel()
        label.text = "Get rate alerts straight to your email inbox"
        return label
    }()
    
    private func blankValueFormatter() -> IAxisValueFormatter {
        class blankIAxisValueFormatter: IAxisValueFormatter {
            func stringForValue(_ value: Double, axis: AxisBase?) -> String {
                 ""
            }
        }
        return blankIAxisValueFormatter()
    }
    
    private let emailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Get rate alerts straight to your email inbox", attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, .font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.white]), for: .normal)
        return button
    }()


    private lazy var lineChart: LineChartView = {
        let view = LineChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        view.xAxis.labelPosition = XAxis.LabelPosition.bottom
        view.xAxis.axisLineColor = .clear
        view.leftAxis.axisLineColor = .clear
        view.rightAxis.drawGridLinesEnabled = false
        view.rightAxis.drawAxisLineEnabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.xAxis.drawGridLinesEnabled = false
        view.rightAxis.drawLabelsEnabled = false
        view.leftAxis.valueFormatter = blankValueFormatter()
        view.xAxis.valueFormatter = blankValueFormatter()
        
        
        var labels: [String] = []
        var entries: [ChartDataEntry] = []
        
        for x in stride(from: 0, to: dummyData.count, by: 1) {
            let data = dummyData[x]
            entries.append(ChartDataEntry(x: Double(x), y: Double(data.rate)))
            labels.append(data.date)
        }

        let markerView = LineMarkerView(labels, for: view)
        view.marker = markerView
        
        let lineDataSet = LineChartDataSet(entries: entries, label: "")
        let lineData = LineChartData(dataSet: lineDataSet)
        
        view.data = lineData
        
        lineDataSet.drawCircleHoleEnabled = false
        lineDataSet.circleRadius = 0
        lineDataSet.form = .none
        lineDataSet.highlightColor = CustomColor.green ?? UIColor.white
        
        let colours = [UIColor.white.withAlphaComponent(0.1).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: [0.1, 0.5])

        lineDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        lineDataSet.drawFilledEnabled = true
        lineDataSet.drawValuesEnabled = false
        
        lineDataSet.setColor(UIColor.clear)
        
        lineData.setDrawValues(false)

        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(lineChart)
        stackView.addArrangedSubview(emailButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    private func setupView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = CustomColor.graphBlue
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        self.addSubview(tabView)
        self.addSubview(vStack)

        
        tabView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        tabView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tabView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        vStack.topAnchor.constraint(equalTo: tabView.bottomAnchor, constant: 20).isActive = true
        vStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true

    }
}
