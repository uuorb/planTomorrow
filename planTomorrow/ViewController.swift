//
//  ViewController.swift
//  planTomorrow
//
//  Created by me293 on 2018/2/21.
//  Copyright © 2018年 hpy. All rights reserved.
//

import UIKit
import Lottie
import JTAppleCalendar
import AudioToolbox
import SnapKit

//MARK: 颜色
public let myColorYellow = UIColor.init(colorWithHexValue: 0xEDCDBD)
public let myColorRed = UIColor.init(colorWithHexValue: 0xE03636)

enum Mode:Int {
    case NONE
    case Main
    case EditMode
    case ShowMode
    case ShowDetail
}

enum Event:Int {
    case ClickLeftButton
    case ClickRightButton
    case ClickCalendarView
    case LongPressCalendarView
    
    case LongPressDetailView
    case SwipeDownDetailView
    case SwipeRightDetailView
    case SwipeLeftDetailView
    
    case SwipeRightFurtherDetailView
    case SwipeLeftFurtherDetailView
}

class ViewController: UIViewController,JTAppleCalendarViewDelegate,JTAppleCalendarViewDataSource{
    //MARK: 属性
    var longPressDate = Date()
    var nowSelected = Date()
    let formatter = DateFormatter()
    var startDate = Date()
    var endDate = Date()

    var dataLabel = UILabel()

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    //一些尺寸
    let mainViewLeft = UIScreen.main.bounds.width / 375 * 19.04
    let mainViewTop = (UIScreen.main.bounds.height / 667 * 1.2) * 57.19
    let initButtonSize = UIScreen.main.bounds.width * 0.12
    
    
    //各个View
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.height
    let rightButton = UIButton()
    let leftButton = UIButton()
    let mainView = MainView()
    
    
    let showDetailView = MainView(frame: CGRect(origin: CGPoint(x:0 ,y: 50 + UIScreen.main.bounds.height  ), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)))
    
    var preMode = Mode.NONE
    var currentMode = Mode.Main
    var bottomView = LOTAnimationView()
    var tmp:Dictionary<Date,Double> = [:]
    
    //MARK: Debug
    var debugLabel = UILabel(frame: CGRect(x: 80 , y: 75 , width: 200, height: 40))
    func initDeBugMode(){
        debugLabel.textAlignment = .center
//        self.view.addSubview(debugLabel)
    }

    @objc func longPressCalendarView(gesture: UILongPressGestureRecognizer) {
        let startGenerator = UIImpactFeedbackGenerator(style: .medium)
        let endGenerator = UIImpactFeedbackGenerator(style: .heavy)

        let point = gesture.location(in: gesture.view!)
        let cellState = calendarView.cellStatus(at: point)
        switch gesture.state {
        case .began:
            startGenerator.impactOccurred()
            print("开始")
//            print(cellState!.date)
        case .cancelled:
            print("cancelled")
        case .ended:
            endGenerator.impactOccurred()
            SM_ReceiveEvent(.LongPressCalendarView)
            print("ended")
        case .possible:
            print("possible")
        default:
            print("default")
        }
        
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        startDate = formatter.date(from: "2018-01-01")!

        endDate = formatter.date(from: "2018-12-31")!

        //初始化view
        initViewState()
        //debug模式
        initDeBugMode()
        //添加测试数据
        addTestData()
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressCalendarView(gesture:)))
        longPressGesture.minimumPressDuration = 0.5
        calendarView.addGestureRecognizer(longPressGesture)
        
        UIView.animate(withDuration: 0.5, delay: 0.5,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowUserInteraction,.curveEaseIn],
                       animations: {
                        self.mainView.center.x += self.view.bounds.width
                        self.bottomView.center.x += self.view.bounds.width
                        self.mainView.alpha = 1.0
        }, completion: nil)

        UIView.animate(withDuration: 0.5, delay: 0.9,
                       usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [.allowUserInteraction],
                       animations: {
                        self.rightButton.center.y += 160.0
                        self.leftButton.center.y += 160.0
        }, completion: nil)
        view.bringSubview(toFront: calendarView)
    }
    
    //MARK: TestData
    func addTestData(){
        for i in 1...50 {
            tmp[startDate.addingTimeInterval(24*60*60*Double.init(i))] = Double(arc4random_uniform(100)) / 100.0
        }
        tmp[startDate.addingTimeInterval(24*60*60*Double.init(5))] = 1.0
        tmp[startDate.addingTimeInterval(24*60*60*Double.init(14))] = 1.0
        tmp[startDate.addingTimeInterval(24*60*60*Double.init(23))] = 1.0
        tmp[startDate.addingTimeInterval(24*60*60*Double.init(9))] = 1.0
    }
    
    
    func initViewState(){
        //创建view
        
        //mainView
        initMainView()
        //bottomView
        initbottomView()
        //showDetailView
        initShowDetailView()
        //calendarView
        initCalendarView()
        //monthLabel
//        initMonthLabel()
        //weekLabel
//        initWeekLabels()
        //Button
        //leftButton
        initLeftButton()
        //rightButton
        initRightButton()
        
        //添加View
//        self.view.bringSubview(toFront: calendarView)
//        self.view.bringSubview(toFront: monthLabel)
        self.view.addSubview(showDetailView)
        self.view.addSubview(rightButton)
//        view.bringSubview(toFront: calendarView)
    }
    

    //MARK: - 创建View
    func initMainView(){
        self.view.addSubview(mainView)
//        print(SCREEN_HEIGHT)
//        mainView.transform = CGAffineTransform(scaleX: SCREEN_WIDTH/375, y: SCREEN_HEIGHT / 667)
        mainView.snp.makeConstraints { (make) -> Void in
          make.edges.equalTo(view).inset(UIEdgeInsetsMake(SCREEN_WIDTH * 0.05, 0, 0, 0))
        }

        mainView.backgroundColor = UIColor.clear
        mainView.layer.shadowOffset = CGSize(width: 10, height: 10)
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowRadius = 8
        mainView.layer.shadowOpacity = 0.5
        mainView.clipsToBounds = false
    }
    
    func initbottomView(){
        

        let path = Bundle.main.path(forResource: "final3", ofType: "json")
        bottomView = LOTAnimationView(filePath: path!)

        self.view.addSubview(bottomView)
//        bottomView.frame = CGRect(origin: CGPoint(x: 10.4 - self.view.bounds.width ,y: 224.5 + 50), size: CGSize(width: 352.5, height: 350))

        bottomView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.mainView.snp.left).offset(mainViewLeft - SCREEN_WIDTH * 0.024)
            make.right.equalTo(self.mainView.snp.right).offset(-mainViewLeft + SCREEN_WIDTH * 0.02)
            make.top.equalTo(self.mainView.snp.centerY).offset(-SCREEN_HEIGHT * 0.10)
            make.height.equalTo(SCREEN_HEIGHT * 0.62)
//            make.height.equalTo(self.mainView.snp.top).priority(.medium)
        }
        
        bottomView.layoutIfNeeded()

        bottomView.animationSpeed = 1.3
        bottomView.backgroundColor = UIColor.clear
        bottomView.layer.shadowColor = UIColor.gray.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 10, height: 10)
        bottomView.layer.shadowRadius = 8
        bottomView.layer.shadowOpacity = 0.5
        bottomView.clipsToBounds = false
    }
    
    func initShowDetailView(){
        showDetailView.backgroundColor = UIColor.clear
        showDetailView.isHidden = true
        
        //绑定手势
        let showDetailSwipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(showDetailGestureFunc(_:)))
        showDetailSwipeGestureDown.direction = UISwipeGestureRecognizerDirection.down
        
        let showDetailSwipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(showDetailGestureFunc(_:)))
        showDetailSwipeGestureRight.direction = UISwipeGestureRecognizerDirection.right

        let showDetailSwipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(showDetailGestureFunc(_:)))
        showDetailSwipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        
        let showDetailLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showDetailLongPressFunc))
        showDetailLongPressGesture.minimumPressDuration = 0.7
        
        showDetailView.addGestureRecognizer(showDetailSwipeGestureDown)
        showDetailView.addGestureRecognizer(showDetailSwipeGestureRight)
        showDetailView.addGestureRecognizer(showDetailSwipeGestureLeft)
        showDetailView.addGestureRecognizer(showDetailLongPressGesture)
    }
    
    func initCalendarView(){
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        //样式上
        calendarView.isHidden = true
        calendarView.alpha = 0
        calendarView.backgroundColor = UIColor.clear
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        //功能上
        calendarView.allowsMultipleSelection = false
        calendarView.isRangeSelectionUsed = true
        calendarView.reloadData()
//        设置约束
        
        calendarView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.mainView.snp.left).offset(mainViewLeft + 10 )
            make.right.equalTo(self.mainView.snp.right).offset(-mainViewLeft - 10)
            make.top.equalTo(self.mainView.snp.top).offset((SCREEN_HEIGHT /
                667) * 1.2 * 120)
            make.bottom.equalTo(self.mainView.snp.bottom).offset(-(SCREEN_HEIGHT /
                667) * 1.2 * 100)
//            make.height.equalTo(self.mainView.snp.height).offset( -self.mainView.frame.height * 0.8)
        }

    }
    
//    func initMonthLabel(){
//        self.monthLabel.center.y = 500//self.leftButton.center.y
//        monthLabel.textColor = myColorRed
//        monthLabel.isHidden = true
//        monthLabel.alpha = 0
//    }
    
    func initLeftButton(){
        //leftButton
        self.view.addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: initButtonSize, height: initButtonSize))
            make.left.equalTo(self.mainView.snp.left).offset(mainViewLeft)
            make.top.equalTo(view).offset(SCREEN_WIDTH * 0.1)
        }
        
        leftButton.layoutIfNeeded()
        leftButton.backgroundColor = myColorRed
        leftButton.layer.cornerRadius = leftButton.frame.width / 2
        leftButton.clipsToBounds = true
        leftButton.addTarget(self, action: #selector(clickLeftButtonFunc), for: UIControlEvents.touchUpInside)
        //添加阴影 - 在圆角的情况下
        leftButton.layer.shadowColor = UIColor.gray.cgColor
        leftButton.layer.shadowRadius = 8
        leftButton.layer.shadowOpacity = 0.5
        leftButton.layer.masksToBounds = false //key
        leftButton.layer.shadowOffset = CGSize(width: 5, height: 3)
        let leftButtonBackgroundCGColor = leftButton.backgroundColor?.cgColor //key
        leftButton.backgroundColor = nil
        leftButton.layer.backgroundColor =  leftButtonBackgroundCGColor
    }

    func initRightButton(){
        
        self.view.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: initButtonSize, height: initButtonSize))
            make.right.equalTo(self.mainView.snp.right).offset(-mainViewLeft)
            make.top.equalTo(view).offset(SCREEN_WIDTH * 0.1)
        }
        rightButton.layoutIfNeeded()

        rightButton.backgroundColor = UIColor(red: 0.879, green: 0.212, blue: 0.213, alpha: 1.000)
        rightButton.layer.cornerRadius = rightButton.frame.size.width / 2
        rightButton.clipsToBounds = true
        
        //添加阴影 - 在圆角的情况下
        rightButton.layer.shadowColor = UIColor.gray.cgColor
        rightButton.layer.shadowRadius = 8
        rightButton.layer.shadowOpacity = 0.5
        rightButton.layer.masksToBounds = false //key
        rightButton.layer.shadowOffset = CGSize(width: 5, height: 3)
        let rightButtonBackgroundCGColor = rightButton.backgroundColor?.cgColor //key
        rightButton.backgroundColor = nil
        rightButton.layer.backgroundColor =  rightButtonBackgroundCGColor
        rightButton.addTarget(self, action: #selector(clickRightButtonFunc), for: UIControlEvents.touchUpInside)
    }
    
//    func initWeekLabels(){
//        for weekLabel in weekLabelS! {
//            weekLabel.textColor = UIColor.white
//        }
//    }
//
    //MARK: - 动画
    //眨眼睛
    func blinkAnimation() {
        //随机左眼或者右眼眨一下
        let tmpButton = (arc4random_uniform(2) == 0) ? leftButton:rightButton
        UIView.animate(withDuration: 0.2, delay: 0,options: [.allowUserInteraction],animations:{
            tmpButton.transform = CGAffineTransform(scaleX: 1.3, y: 0.3)
        },completion:{
            _ in
            UIView.animate(withDuration: 0.2,delay: 0,options: [.allowUserInteraction],animations:{
                tmpButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    func blinkAnimation(_ button: UIButton) {
        //随机左眼或者右眼眨一下
        let tmpButton = button
        UIView.animate(withDuration: 0.2, delay: 0,options: [.allowUserInteraction],animations:{
            tmpButton.transform = CGAffineTransform(scaleX: 1, y: 0.3)
        },completion:{
            _ in
            UIView.animate(withDuration: 0.2, delay: 0,options: [.allowUserInteraction],animations:{
                tmpButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    //MARK: - 事件监听
    @objc func didStartRangeSelecting(gesture:UILongPressGestureRecognizer){
        print("拉了")
    }
    
    @objc func showDetailLongPressFunc(){
        print("长按了")
    }
    
    @objc func showDetailGestureFunc(_ sender: UISwipeGestureRecognizer){
        switch sender.direction{
            case UISwipeGestureRecognizerDirection.right:
                print("Right")
            case UISwipeGestureRecognizerDirection.left:
                print("Left")
            case UISwipeGestureRecognizerDirection.down:
                SM_ReceiveEvent(.SwipeDownDetailView)
                print("Down")
            default:
                print("UnKnow - Direction")
        }
    }
    
    @objc func clickLeftButtonFunc(){
        SM_ReceiveEvent(.ClickLeftButton)
    }
    
    @objc func clickRightButtonFunc(){
        SM_ReceiveEvent(.ClickRightButton)
    }
        
    
    //MARK: 状态机
    //收集事件相应->判断+分配任务
    
    //收集+判断 事件
    //改变Mode
    func SM_ReceiveEvent(_ receivedEvent:Event){
        if(receivedEvent == .ClickLeftButton){
            blinkAnimation(leftButton)
        }
        
        if(receivedEvent == .ClickRightButton){
            blinkAnimation(rightButton)
        }
        
        print("接收事件: \(receivedEvent)")
        print("未处理前: preMode: \(preMode) | currentMode: \(currentMode)")
        switch currentMode {
        case .Main:
            if (receivedEvent == .ClickLeftButton){
                currentMode = .ShowMode
                preMode = .Main
                SM_HandleEvent()
            }
            
            if (receivedEvent == .ClickRightButton){
                currentMode = .EditMode
                preMode = .Main
                SM_HandleEvent()
            }
        case .ShowMode:
            if (receivedEvent == .ClickLeftButton || receivedEvent == .ClickRightButton){
                currentMode = .Main
                preMode = .ShowMode
                SM_HandleEvent()
            }
            if (receivedEvent == .LongPressCalendarView){
                currentMode = .ShowDetail
                preMode = .ShowMode
                SM_HandleEvent()
            }
        case .EditMode:
            if (receivedEvent == .ClickLeftButton || receivedEvent == .ClickRightButton){
                currentMode = .Main
                preMode = .EditMode
                SM_HandleEvent()
            }
        case .ShowDetail:
            if (receivedEvent == .SwipeDownDetailView){
                currentMode = .ShowMode
                preMode = .ShowDetail
                SM_HandleEvent()
            }
        default:
            do{
                blinkAnimation()
            }
        }
        
        print("处理后: preMode: \(preMode) | currentMode: \(currentMode)")
        
    }
    
    //根据Mode分配事情
    func SM_HandleEvent(){
        //deBug
        switch currentMode {
        case .ShowMode:
            debugLabel.text = "查看模式"
        case .EditMode:
            debugLabel.text = "编辑模式"
        case .Main:
            debugLabel.text = "主界面"
        case .ShowDetail:
            debugLabel.text = "详情模式"
        default:
            debugLabel.text = "错误模式"
        }
        
        print("处理事件:\(preMode) -> \(currentMode)")
        
        if preMode == .Main && currentMode == .ShowMode{
            SM_MainToShow()
        }
        
        if preMode == .Main && currentMode == .EditMode{
            SM_MainToEdit()
        }
        
        if preMode == .ShowMode && currentMode == .Main{
            SM_ShowToMain()
        }
        if preMode == .ShowMode && currentMode == .ShowDetail{
            SM_ShowToDetail()
        }
        if preMode == .EditMode && currentMode == .Main{
            SM_EditToMain()
        }
        if preMode == .ShowDetail && currentMode == .ShowMode{
            SM_DetailToShow()
        }
        
    }
    
    func SM_ShowToMain(){
        self.rightButton.isEnabled = false
        self.leftButton.isEnabled = false

        //日历，月份Label消失，bottomView回来，眼睛颜色恢复
        self.bottomView.isHidden = false
        self.bottomView.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
//            self.monthLabel.alpha = 0
            self.calendarView.alpha = 0
        })
        UIView.animate(withDuration: 0.5, delay: 0,
                       usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.allowUserInteraction,.curveEaseIn],
                       animations: {
                        self.leftButton.backgroundColor = myColorRed
                        self.leftButton.backgroundColor = myColorRed
                        self.bottomView.center.y -= self.view.bounds.height * 0.7
                        self.mainView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion:  {
            _ in
//            self.monthLabel.isHidden = true
            self.calendarView.isHidden = true
            self.leftButton.isEnabled = true
            self.rightButton.isEnabled = true
        })
    }
    
    func SM_ShowToDetail(){
        showDetailView.isHidden = false
//        monthLabel.isHidden = true
//        calendarView.layer.removeAllAnimations()
        //把mainview前置
        UIView.animate(withDuration: 0.8, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [],animations:{
            self.mainView.center.y -= self.SCREEN_HEIGHT * 0.35
//            self.calendarView.alpha = 0
            self.mainView.alpha = 0.9
            self.mainView.transform = CGAffineTransform(scaleX: 1, y: 0.6)
            let scale = CGAffineTransform(scaleX: 1, y: 1.5)
            let translation = scale.translatedBy(x: 0, y: 80)
            
            self.leftButton.center.y += 60
            self.rightButton.center.y += 60
            self.rightButton.backgroundColor = myColorYellow
            
            
            self.showDetailView.transform = translation
            self.showDetailView.center.y -= self.view.bounds.height
        },completion:nil
            //{
//            _ in self.calendarView.isHidden = true}
            //}
        )
    }
        
    
    
    //在动画未完成时，响应手势
    func SM_DetailToShow(){
        //
//        self.calendarView.layer.removeAllAnimations()
//        self.calendarView.isHidden = false
//        self.view.bringSubview(toFront: self.calendarView)
        
        UIView.animate(withDuration: 1.0, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowUserInteraction],animations:{
            self.mainView.center.y += self.SCREEN_HEIGHT * 0.35
            
            //self.calendarView.reloadData()
//            self.calendarView.alpha = 1
            
//            print(self.calendarView.center.y)
//            self.monthLabel.alpha = 1
            self.mainView.alpha = 1
            self.leftButton.center.y -= 60
            self.rightButton.center.y -= 60
            self.rightButton.backgroundColor = myColorRed

            let scale = CGAffineTransform(scaleX: 1, y: 1.3)
            let translation = scale.translatedBy(x: 0, y: 40)
            self.mainView.transform = translation
            
            self.showDetailView.center.y += self.view.bounds.height
            
        },completion:nil)
    }

    
    
    func SM_MainToShow(){
        //动画完成前，禁用掉两个button
        //眨眼睛，按钮变颜色，日历出现，月份Label出现
        //bottomView从下滑走
//        self.view.bringSubview(toFront: self.weekLabelStack)
        
        self.rightButton.isEnabled = false
        self.leftButton.isEnabled = false
        self.calendarView.isHidden = false
//        self.monthLabel.isHidden = false

        blinkAnimation()

        UIView.animate(withDuration: 1.0, delay: 0.2,
                       usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: [.allowUserInteraction,.curveEaseInOut],
                       animations: {
                        self.leftButton.backgroundColor = myColorYellow
                        self.bottomView.center.y += self.view.bounds.height * 0.7
                        
                        //要累积形变的话，不能直接赋值，最后赋值
                        self.bottomView.alpha = 0
                        self.calendarView.reloadData() //日历数据刷新
                        let scale = CGAffineTransform(scaleX: 1, y: 1.3)
                        let translation = scale.translatedBy(x: 0, y: 40)
                        self.mainView.transform = translation
                        self.calendarView.alpha = 1
                        //日历
//                        self.monthLabel.alpha = 1
                    }, completion: {
                        _ in
                        self.bottomView.isHidden = true
                        self.leftButton.isEnabled = true
                        self.rightButton.isEnabled = true
                    })
    }
    
    func SM_MainToEdit(){
        blinkAnimation()
        self.rightButton.isEnabled = false
        self.leftButton.isEnabled = false
        UIView.animate(withDuration: 0.6, animations:{self.rightButton.backgroundColor = myColorYellow}
        )
        bottomView.play(fromProgress: 0.1, toProgress: 0.8, withCompletion: {
            _ in
            self.rightButton.isEnabled = true //恢复
            self.leftButton.isEnabled = true
        })

    }
    
    func SM_EditToMain(){
        blinkAnimation()
        self.rightButton.isEnabled = false
        self.leftButton.isEnabled = false
        
        UIView.animate(withDuration: 0.6, animations:{
            self.rightButton.backgroundColor = myColorRed
            self.leftButton.backgroundColor = myColorRed
        })

        bottomView.play(fromProgress: 0.8, toProgress: 0.2, withCompletion: {
            _ in
            self.rightButton.isEnabled = true //恢复
            self.leftButton.isEnabled = true
        })
    }

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate,numberOfRows: 1,generateInDates: .forAllMonths
            , generateOutDates: .tillEndOfRow
        )
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        formatter.dateFormat = "MMMM"
        //        self.monthLabel.text = formatter.string(from: date)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath){
        // This function should have the same code as the cellForItemAt function
        let mycell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        showCell(cell: mycell,cellState: cellState)
    }
    

    
    //合并下面两个函数
    func showCell(cell: CustomCell,cellState: CellState){
        //设置约束
        cell.layoutIfNeeded()
        cell.selectedView.layer.cornerRadius = cell.selectedView.layer.bounds.size.width / 2
        cell.dataLabel.text = cellState.text
        cell.selectedView.layer.borderWidth = 1
        cell.selectedView.layer.borderColor = UIColor.white.cgColor
        cell.coverView.backgroundColor = UIColor.white
        var tmp_value = 0.0
        if tmp[cellState.date] != nil {
            tmp_value = tmp[cellState.date]!
        }
        print(tmp_value)
        cell.hatImageView.isHidden = true

        let hatTransform_1 = CGAffineTransform(rotationAngle: CGFloat.pi * 0.15)
        let hatTransform_2 = hatTransform_1.translatedBy(x: -3, y: -27.5)
        let hatTransform_3 = hatTransform_2.scaledBy(x: 0.8, y: 0.8)
        cell.hatImageView.transform = hatTransform_3
        
        cell.selectedView.backgroundColor = myColorRed
        cell.dataLabel.textColor = UIColor.black
        cell.coverView.isHidden = false
        cell.selectedView.clipsToBounds = true
        UIView.animate(withDuration: 1.5,
                       delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0, options: [],
                       animations: {cell.coverView.transform = CGAffineTransform(translationX: 0, y: CGFloat(40 * (1 - tmp_value)))},
                       completion: nil)
        cell.selectedView.layer.borderWidth = 1
        cell.selectedView.layer.borderColor = UIColor.white.cgColor
        cell.selectedView.isHidden = false
        if tmp_value >= 0.95{
            UIView.animate(withDuration: 0.5, animations: {
                cell.selectedView.layer.borderColor = UIColor.black.cgColor
                cell.hatImageView.isHidden = false
                cell.hatImageView.alpha = 1
            })
        }
        if tmp_value < 0.3 {
            UIView.animate(withDuration: 0.5, animations: {cell.dataLabel.textColor = UIColor.white})
        }else{
            UIView.animate(withDuration: 0.5, animations: {cell.dataLabel.textColor = UIColor.black})
        }

    }
    
    
    //显示单个cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        showCell(cell: cell, cellState: cellState)
        return cell
    }
    
    
    func handleSelection(cell: JTAppleCell?, cellState: CellState) {
        let myCustomCell = cell as! CustomCell
        myCustomCell.clipsToBounds = false
        calendarView.clipsToBounds = true

        if let tmp_value = self.tmp[cellState.date]{
            if myCustomCell.isSelected {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                    myCustomCell.coverView.backgroundColor = UIColor.black
                    myCustomCell.selectedView.layer.borderColor = UIColor.black.cgColor
                    myCustomCell.selectedView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    myCustomCell.coverView.center.y -= CGFloat( 40 * (1 - tmp_value) * 0.5)
                    myCustomCell.dataLabel.textColor = UIColor.white
                }, completion:nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                    myCustomCell.coverView.backgroundColor = UIColor.white
                    myCustomCell.selectedView.layer.borderColor = UIColor.white.cgColor
                    myCustomCell.selectedView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    myCustomCell.coverView.center.y += CGFloat( 40 * (1 - tmp_value) * 0.5)
                    myCustomCell.dataLabel.textColor = UIColor.black
                }, completion: nil)
            }
        }else{
            if myCustomCell.isSelected {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                    myCustomCell.selectedView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    myCustomCell.dataLabel.textColor = UIColor.black
                    myCustomCell.selectedView.layer.borderColor = UIColor.black.cgColor
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                    myCustomCell.selectedView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    myCustomCell.dataLabel.textColor = UIColor.white
                    myCustomCell.selectedView.layer.borderColor = UIColor.white.cgColor
                }, completion: nil)
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if (nowSelected != date && cell != nil) {
            handleSelection(cell: cell, cellState: cellState)
            SM_ReceiveEvent(.ClickCalendarView)
            nowSelected = date
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if (cell != nil ){
            handleSelection(cell: cell, cellState: cellState)
        }
    }
    
}

extension UIColor{
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((value & 0x0000FF)) / 255.0,
            alpha: alpha
        )
    }
}

