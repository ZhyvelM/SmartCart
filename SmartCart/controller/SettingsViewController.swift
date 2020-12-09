//
//  SettingsViewController.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 11/30/20.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var termSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((CurrentTheme.current as? LightTheme) != nil)
        {
            themeControl.selectedSegmentIndex = 0
        }else if ((CurrentTheme.current as? DarkTheme) != nil)
        {
            themeControl.selectedSegmentIndex = 2
        }else if ((CurrentTheme.current as? EyeCareTheme) != nil)
        {
            themeControl.selectedSegmentIndex = 1
        }
        
        self.navigationController?.navigationBar.barTintColor = CurrentTheme.current.backgroundColor
        self.navigationController?.navigationBar.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CurrentTheme.current.fontColor]
        self.tabBarController?.tabBar.tintColor = CurrentTheme.current.fontColor
        self.tabBarController?.tabBar.barTintColor =  CurrentTheme.current.backgroundColor
        self.view.backgroundColor = CurrentTheme.current.backgroundColor
        themeLabel.textColor = CurrentTheme.current.fontColor
        termLabel.textColor = CurrentTheme.current.fontColor
        termSlider.tintColor = CurrentTheme.current.fontColor
        termSlider.value = Float(Settings.expireTime_2)
        termSlider.thumbTintColor = CurrentTheme.current.accentColor
        themeControl.backgroundColor = CurrentTheme.current.accentColor
        themeControl.selectedSegmentTintColor = CurrentTheme.current.backgroundColor
        themeControl.layer.borderColor = CurrentTheme.current.fontColor.cgColor
        themeControl.layer.borderWidth = 1
        themeControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: CurrentTheme.current.fontColor], for: .normal)
    }
    
    func ThemeChange() {
        self.navigationController?.navigationBar.barTintColor = CurrentTheme.current.backgroundColor
        self.navigationController?.navigationBar.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CurrentTheme.current.fontColor]
        self.tabBarController?.tabBar.tintColor = CurrentTheme.current.fontColor
        self.tabBarController?.tabBar.barTintColor =  CurrentTheme.current.backgroundColor
        self.view.backgroundColor = CurrentTheme.current.backgroundColor
        themeLabel.textColor = CurrentTheme.current.fontColor
        termLabel.textColor = CurrentTheme.current.fontColor
        termSlider.thumbTintColor = CurrentTheme.current.accentColor
        termSlider.tintColor = CurrentTheme.current.fontColor
        themeControl.backgroundColor = CurrentTheme.current.accentColor
        themeControl.selectedSegmentTintColor = CurrentTheme.current.backgroundColor
        themeControl.layer.borderColor = CurrentTheme.current.fontColor.cgColor
        themeControl.layer.borderWidth = 1
        themeControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: CurrentTheme.current.fontColor], for: .normal)
    }
    
    @IBAction func changeTheme(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            CurrentTheme.current = LightTheme()
        }else if sender.selectedSegmentIndex == 1{
            CurrentTheme.current = EyeCareTheme()
        }else if sender.selectedSegmentIndex == 2{
            CurrentTheme.current = DarkTheme()
        }
        ThemeChange()
    }
    
    @IBAction func TermChanged(_ sender: UISlider) {
        Settings.expireTime_2 = Int(sender.value)        
    }
}
