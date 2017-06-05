//
//  CharController.swift
//  NIKKAMaster
//
//  Created by toby on 03/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

import UIKit
import Charts

class CharController : NKViewController ,ChartViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var chartViewSize:CGSize = CGSize.init(width: 0, height: 0)
    var chartLables = [String]()
    var _chartDatas = [[Double]]()
        
    var chartDatas:[[Double]]{
        set{
        _chartDatas = newValue
        }
        get{
            return [[20.0, 0.0, 0.0, 0.0, 0.0, 16.0,
                     4.0, 50.0, 2.0, 4.0, 5.0, 4.0,
                     20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
                     4.0, 18.0, 2.0, 4.0, 5.0, 4.0],
                    
                    [20.0, 0.0, 0.0, 0.0, 0.0, 16.0,
                     4.0, 50.0, 2.0, 4.0, 5.0, 4.0,
                     20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
                     4.0, 18.0, 2.0, 4.0, 5.0, 4.0],
                    
//                    30天
                [20.0, 0.0, 0.0, 0.0, 0.0, 16.0,
                 4.0, 50.0, 2.0, 4.0, 5.0, 4.0,
                 20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
                 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                 4.0, 18.0, 2.0, 4.0, 5.0, 4.0],
                
//                31天
                [20.0, 0.0, 0.0, 0.0, 0.0, 16.0,
                 4.0, 50.0, 2.0, 4.0, 5.0, 4.0,
                 20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
                 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,35.0]]
        }
    }
    
    override func  viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.blue

        
        self.chartViewSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT/2)
        self.chartLables.append("各个时段用户使用APP情况")
        self.chartLables.append("各个时段消费情况")
        self.chartLables.append("每天用户使用人数 (日活)")
        self.chartLables.append("日消费统计")
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.chartViewSize
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        
       let collectionView = UICollectionView.init(frame:CGRect(x:0, y:64, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - 64 - 49), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self;
        //注册一个cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "HotCell")
        collectionView.backgroundColor = UIColor.red
        self.view.addSubview(collectionView)
        
        
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
//        setChart(dataPoints: months, values: unitsSold)
        
//        createLineChartView()
//        setChart(dataPoints: months, values: unitsSold, lineChartView: self.linechartView!)
//        createBarChartView()
//       setChart(dataPoints: months, values: unitsSold, chartView: self.barChartView!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotCell", for: indexPath)
        
        srand48(Int(time(nil)))
        cell.backgroundColor = UIColor.init(red:CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
//        let unitsSold = [20.0, 0.0, 0.0, 0.0, 0.0, 16.0,
//                         4.0, 50.0, 2.0, 4.0, 5.0, 4.0,
//                         20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
//                         4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        let lineChartView = createLineChartView(values: self.chartDatas[indexPath.row],lable: self.chartLables[indexPath.row])
        cell.addSubview(lineChartView)
        return cell
    }
    
    func createLineChartView(values:[Double], lable:String) -> LineChartView
    {
    
        let lineChartView = LineChartView.init(frame:CGRect(x:0, y:0, width:self.chartViewSize.width, height:self.chartViewSize.height))
//        chartView.lineData
        // 签协议
        lineChartView.delegate = self
        lineChartView.noDataText = "木有数据"
        lineChartView.backgroundColor = UIColor.white
    
        //添加数据
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry.init(x: Double(i)+1, y: values[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label:lable)
        lineChartView.data = LineChartData.init(dataSets: [chartDataSet])
        return lineChartView
    }
//    func setChart(dataPoints: [String], values: [Double],lineChartView:LineChartView) {
//        var dataEntries: [ChartDataEntry] = []
//        
//        for i in 0..<values.count {
//            let dataEntry = ChartDataEntry.init(x: Double(i), y: values[i])
//            dataEntries.append(dataEntry)
//        }
//        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Units Sold")
//        
//        
//        lineChartView.data = LineChartData.init(dataSets: [chartDataSet])
//        //        chartView.data = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
//        
////        // 加上一个界限, 演示图中红色的线
////        let jx = ChartLimitLine(limit: 12.0, label: "I am LimitLine")
////        chartView.rightAxis.addLimitLine(jx)
//        //        // 自定义颜色
//        //        // 例子中有十二个柱状图
//        //        // colors 是一个数组, 可以给相应的颜色
//        //        chartDataSet.colors = [UIColor.blue, UIColor.red, UIColor.cyan]
//        //        // API 自带颜色模板
//        //        // ChartColorTemplates.liberty()
//        //        // ChartColorTemplates.joyful()
//        //        // ChartColorTemplates.pastel()
//        //        // ChartColorTemplates.colorful()
//        //        // ChartColorTemplates.vordiplom()
//        //        chartDataSet.colors = ChartColorTemplates.liberty()
//        //        /**
//        //         // 动画效果, 简单列举几个, 具体请看API
//        //         case EaseInBack
//        //         case EaseOutBack
//        //         case EaseInOutBack
//        //         case EaseInBounce
//        //         case EaseOutBounce
//        //         case EaseInOutBounce
//        //         */
//        //        // 加上动画
//        ////        chartView.animate(yAxisDuration: 1.0, easingOption: .EaseInBounce)
//    }

//
//    func createBarChartView()
//    {
//        self.barChartView = BarChartView.init(frame: CGRect(x:0, y:64, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - 64 - 49))
////        self.barChartViewchartView.barData
//        // 签协议
//        self.barChartView?.delegate = self
//        self.barChartView?.noDataText = "木有数据"
//        self.barChartView?.backgroundColor = UIColor.white
//        
//        self.view.addSubview(self.barChartView!)
//    }
//    
//    func setChart(dataPoints: [String], values: [Double],barChartView:BarChartView) {
//        var dataEntries: [BarChartDataEntry] = []
//        
//        for i in 0..<values.count {
//            let dataEntry = BarChartDataEntry.init(x: Double(i), y: values[i])
//            dataEntries.append(dataEntry)
//        }
//        let chartDataSet = BarChartDataSet.init(values: dataEntries, label: "Units Sold")
//        
//        
//        barChartView.data = BarChartData.init(dataSets: [chartDataSet])
//        //        chartView.data = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
//        
//        // 加上一个界限, 演示图中红色的线
//        let jx = ChartLimitLine(limit: 12.0, label: "I am LimitLine")
//        barChartView.rightAxis.addLimitLine(jx)
//        //        // 自定义颜色
//        //        // 例子中有十二个柱状图
//        //        // colors 是一个数组, 可以给相应的颜色
//        //        chartDataSet.colors = [UIColor.blue, UIColor.red, UIColor.cyan]
//        //        // API 自带颜色模板
//        //        // ChartColorTemplates.liberty()
//        //        // ChartColorTemplates.joyful()
//        //        // ChartColorTemplates.pastel()
//        //        // ChartColorTemplates.colorful()
//        //        // ChartColorTemplates.vordiplom()
//        //        chartDataSet.colors = ChartColorTemplates.liberty()
//        //        /**
//        //         // 动画效果, 简单列举几个, 具体请看API
//        //         case EaseInBack
//        //         case EaseOutBack
//        //         case EaseInOutBack
//        //         case EaseInBounce
//        //         case EaseOutBounce
//        //         case EaseInOutBounce
//        //         */
//        //        // 加上动画
//        ////        chartView.animate(yAxisDuration: 1.0, easingOption: .EaseInBounce)
//    }
//    
//    func setChart(dataPoints: [String], values: [Double]) {
//        self.barChartView?.noDataText = "You need to provide data for the chart."
//        
//        var dataEntries: [BarChartDataEntry] = []
//        
//        for i in 0..<dataPoints.count {
//            let dataEntry = BarChartDataEntry(x:Double(i) , yValues: [values[i]])
//            dataEntries.append(dataEntry)
//        }
//        
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
//        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
//        barChartView.data = chartData
//    }
}
