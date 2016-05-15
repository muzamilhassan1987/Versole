//
//  MyPickerView.swift
//  Versole
//
//  Created by Soomro Shahid on 2/27/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

let kPickerViewHeight:CGFloat = 216.0
let kToolBarHeight:CGFloat = 46.0

class MyPickerView: UIView ,UIPickerViewDataSource,UIPickerViewDelegate{

    
    
    var myPicker: UIPickerView!
    var viewContainer: UIView!
    var isUpdateData:Bool!
    var selectedRow:Int?
    //var arrData:NSMutableArray!
    //var selectedData:NSMutableDictionary!
    
    var arrData: NSMutableArray!
    var selectedData: NSMutableDictionary?
    init(arrToShow: NSMutableArray?, currentSelectedData: NSMutableDictionary?,superFrame :CGRect) {
        self.arrData = arrToShow
        self.selectedData = currentSelectedData
        if(self.selectedData != nil) {
            
        }
        super.init(frame: superFrame)
        isUpdateData = false
        let viewBg = UIView.init(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        self.addSubview(viewBg)
        viewBg.alpha = 0.7
        viewBg.backgroundColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        //self.backgroundColor = UIColor.greenColor()
        
        createPickerView()
    }
    
    func createPickerView() {
        
        myPicker = UIPickerView()

        myPicker.backgroundColor = UIColor.clearColor()
        myPicker.delegate = self
        myPicker.dataSource = self
        //myPicker.alpha = 0;
        createToolBar()
        //myPicker.reloadAllComponents()
    }
    func createToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        //toolBar.translucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MyPickerView.donePressed(_:)))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MyPickerView.cancelPressed(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        // toolBar.sizeToFit()
        
        //self.addSubview(toolBar)
        
        viewContainer = UIView.init(frame: CGRectMake(0, self.frame.size.height, self.frame.size.width, toolBar.frame.size.height+myPicker.frame.size.height))
        viewContainer.backgroundColor = UIColor.whiteColor()
        self.addSubview(viewContainer)
        viewContainer.addSubview(toolBar)
        viewContainer.addSubview(myPicker)
        toolBar.frame = CGRectMake(0, 0, viewContainer.frame.size.width, 46)
        myPicker.frame = CGRectMake(0, kToolBarHeight, viewContainer.frame.size.width, 216)
        
        
        
        pickerViewAnimation(true)
        
//        showPickerView()
        //myPicker.inputAccessoryView = toolBar
        
    }
    func pickerViewAnimation(isShow:Bool) {
        
        var distance:CGFloat  = 0.0
        if(isShow){
           distance = -self.viewContainer.frame.size.height
        }
        else {
           distance = self.viewContainer.frame.size.height
        }
        UIView.animateWithDuration(0.6, animations: {
            let transfrom: CGAffineTransform = CGAffineTransformMakeTranslation(0,distance )
            self.viewContainer.transform = transfrom
            }, completion: {
                (value: Bool) in
                if(!isShow){
//                    self.removeFromSuperview()
                    print("ROW IS")
                    print(self.selectedRow)
                    if (!self.isUpdateData) {
                        self.selectedRow = nil
                    }
                    
                    //print(self.selectedRow!)
                    NSNotificationCenter.defaultCenter().postNotificationName("UpdatePickerData", object: self.selectedRow)
 
                    
                }
        })
        
    }
    
    func TESTING(notification: NSNotification) {
        // divert all power to shields
        print(notification)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        
        
    }
    func setDataList(currentDataArray:NSMutableArray) {
        
        arrData = NSMutableArray(array: currentDataArray)
        print(arrData)
        
        
    }
    
    func changeDataArray(currentDataArray:NSMutableArray) {
        
        if (arrData != nil) {
            arrData.removeAllObjects()
        }
        
        arrData = nil
        arrData = NSMutableArray(array: currentDataArray)
        myPicker.reloadAllComponents();
        
        
    }
    @IBAction func cancelPressed(sender: AnyObject) {
        
        isUpdateData = false
        pickerViewAnimation(false)
    }
    @IBAction func donePressed(sender: AnyObject) {
        
        isUpdateData = true
        pickerViewAnimation(false)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        let data = arrData.objectAtIndex(row) as! NSMutableDictionary
        return data.valueForKey("title") as? String
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        selectedRow = row
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
