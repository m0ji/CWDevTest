//
//  LineMarkerView.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 05/01/2021.
//

import Charts

class LineMarkerView: MarkerView {
    private var labels: [String] = []
    

    init(_ labels: [String], for chart: ChartViewBase) {
        super.init(frame: .init(x: 0, y: 0, width: 150, height: 60))
        self.labels = labels
        self.chartView = chart
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        rateLabel.text = String(format: "%@%.2f", "1 EUR = ", entry.y)
        dateLabel.text = DateHelper.convert(date: labels[Int(highlight.x)], to: "dd MMM yyyy")
    }
    
    private func setupView(){
        self.addSubview(contentView)
        dateLabel.frame.origin = .init(x: 4, y: 10)
        dateLabel.frame.size = .init(width: 140, height: 20)
        
        rateLabel.frame.origin = .init(x: 4, y: 30)
        rateLabel.frame.size = .init(width: 140, height: 20)

    }
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: self.frame)
        view.backgroundColor = CustomColor.green
        view.addSubview(dateLabel)
        view.addSubview(rateLabel)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.numberOfLines = 0
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        return view
    }()
    
     private lazy var rateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16)
        view.textAlignment = .left
        return view
     }()
}

