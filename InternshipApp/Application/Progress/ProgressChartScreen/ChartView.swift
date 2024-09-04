//
//  ChartView.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 31.07.2024.
//

import UIKit

final class ChartView: UIView {
    
    var name: String
    
    var valueArray: [Int] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var dateArray: [Double] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(name: String) {
        self.name = name
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard valueArray.count > 1 else { return }
        
        let context = UIGraphicsGetCurrentContext()
        
        let maxY = valueArray.max() ?? 0
        let graphHeight = bounds.height
        let barWidth: CGFloat = Constants.chartBarWidth
        let barSpacing: CGFloat = Constants.chartBarSpacing
        let dateLabelHeight: CGFloat = Constants.chartViewDateLabelHeight
        let bottomPadding: CGFloat = Constants.chartViewBottomPadding
        let startingX: CGFloat = Constants.chartViewStartingX
        let cornerRadius: CGFloat = Constants.chartViewBarCornerRadius
        
        subviews.forEach { $0.removeFromSuperview() }
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setLineWidth(1)
        context?.move(to: CGPoint(x: 0, y: graphHeight - dateLabelHeight - bottomPadding))
        context?.addLine(to: CGPoint(x: bounds.width, y: graphHeight - dateLabelHeight - bottomPadding))
        context?.strokePath()
        
        for (index, value) in valueArray.enumerated() {
            let x = startingX + CGFloat(index) * (barWidth + barSpacing)
            let barHeight = CGFloat(value) / CGFloat(maxY) * (graphHeight - dateLabelHeight - bottomPadding) / 3
            
            let barLayer = CALayer()
            barLayer.frame = CGRect(x: x, y: graphHeight - barHeight - dateLabelHeight - bottomPadding, width: barWidth, height: barHeight)
            barLayer.backgroundColor = UIColor.appYellow.cgColor
            barLayer.cornerRadius = cornerRadius
            barLayer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            layer.addSublayer(barLayer)
            
            let heightAnimation = CABasicAnimation(keyPath: TextValues.buildingBarAnimation)
            heightAnimation.fromValue = 0
            heightAnimation.toValue = barHeight
            heightAnimation.duration = 1
            heightAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            let positionAnimation = CABasicAnimation(keyPath: TextValues.positionAnimation)
            positionAnimation.fromValue = graphHeight - dateLabelHeight - bottomPadding
            positionAnimation.toValue = graphHeight - barHeight / 2 - dateLabelHeight - bottomPadding
            positionAnimation.duration = 1
            positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            barLayer.add(heightAnimation, forKey: TextValues.buildingBarAnimation)
            barLayer.add(positionAnimation, forKey: TextValues.positionAnimation)
            
            let valueLabel = UILabel(frame: CGRect(x: x, y: graphHeight - barHeight - dateLabelHeight - bottomPadding - 25, width: barWidth, height: Constants.chartViewValueLabelHeight))
            valueLabel.text = "\(value) \(name == TextValues.weight ? TextValues.kg : TextValues.cm)"
            valueLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.chartViewValueLabelSize)
            valueLabel.textAlignment = .center
            valueLabel.textColor = .white
            valueLabel.alpha = 0
            addSubview(valueLabel)
            
            let dateLabel = UILabel(frame: CGRect(x: x, y: graphHeight - dateLabelHeight, width: barWidth, height: dateLabelHeight))
            let date = Date(timeIntervalSince1970: dateArray[index])
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM"
            dateLabel.text = dateFormatter.string(from: date)
            dateLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.chartViewDateLabelSize)
            dateLabel.textAlignment = .center
            dateLabel.textColor = .white
            addSubview(dateLabel)
            
            if index > 0 {
                let previousValue = valueArray[index - 1]
                let difference = value - previousValue
                
                if difference != 0 {
                    let differenceView = UIView(frame: CGRect(x: x, y: graphHeight - barHeight - dateLabelHeight - bottomPadding - 55, width: Constants.chartViewDifferenceViewWidth, height: Constants.chartViewDifferenceViewHeight))
                    differenceView.backgroundColor = difference < 0 ? .systemGreen : .appRed
                    differenceView.layer.cornerRadius = Constants.chartViewDifferenceViewCornerRadius
                    differenceView.alpha = 0
                    
                    let differenceLabel = UILabel()
                    differenceLabel.text = "\(difference > 0 ? "+" : "")\(difference) \(name == TextValues.weight ? TextValues.kg : TextValues.cm)"
                    differenceLabel.font = UIFont.systemFont(ofSize: Constants.chartViewDifferenceLabelSize, weight: .bold)
                    differenceLabel.textAlignment = .center
                    differenceLabel.textColor = .white
                    
                    differenceLabel.alpha = 0
                    differenceLabel.translatesAutoresizingMaskIntoConstraints = false
                    
                    differenceView.addSubview(differenceLabel)
                    
                    NSLayoutConstraint.activate([
                        differenceLabel.centerXAnchor.constraint(equalTo: differenceView.centerXAnchor),
                        differenceLabel.centerYAnchor.constraint(equalTo: differenceView.centerYAnchor)
                    ])
                    
                    addSubview(differenceView)
                    
                    UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveEaseOut], animations: {
                        differenceView.alpha = 1
                        differenceLabel.alpha = 1
                        valueLabel.alpha = 1
                    }, completion: nil)
                    
                }
            }
        }
        
        if let firstValue = valueArray.first {
            let firstBarHeight = CGFloat(firstValue) / CGFloat(maxY) * (graphHeight - dateLabelHeight - bottomPadding) / 3
            let yPosition = graphHeight - firstBarHeight - dateLabelHeight - bottomPadding
            
            let dashedLinePath = UIBezierPath()
            dashedLinePath.move(to: CGPoint(x: 0, y: yPosition))
            dashedLinePath.addLine(to: CGPoint(x: bounds.width, y: yPosition))
            
            context?.setStrokeColor(UIColor.white.cgColor)
            context?.setLineWidth(1)
            context?.setLineDash(phase: 0, lengths: [4, 4])
            context?.addPath(dashedLinePath.cgPath)
            context?.strokePath()
        }
    }
}
