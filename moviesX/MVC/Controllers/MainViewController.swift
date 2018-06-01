//
//  MainViewController.swift
//  moviesX
//
//  Created by thejus manoharan on 17/05/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    @IBOutlet weak var btnMovies: UICustomButton!
    @IBOutlet weak var btnTheaters: UICustomButton!
    @IBOutlet weak var viewPgVC: UIView!
    
    @IBOutlet weak var viewLine: UIView!
    var pageId = ""
    var pageViewController: UIPageViewController!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.setPageContent()
        self.pageViewController.view.backgroundColor = UIColor.white
        pageViewController.view.frame = CGRect(x: viewPgVC.frame.origin.x, y: viewPgVC.frame.origin.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        self.pageId=(self.orderedViewControllers.first?.restorationIdentifier)!
        
        
        for view in self.pageViewController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    // MARK: - Page view controller setup
    func setPageContent() {
        pageViewController.setViewControllers([orderedViewControllers.first!], direction: .forward, animated: false, completion: nil)
    }
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(name: "movies"),
                self.newViewController(name: "cinemas")]
    }()
    
    private func newViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(name)VC")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        pageId = viewController.restorationIdentifier!
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        pageId = viewController.restorationIdentifier!
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed) {
            pageId = (pageViewController.viewControllers?.last?.restorationIdentifier)!
        }
        if(pageId == "cinemasVC"){
            UIView.animate(withDuration: 0.2, animations: {
            self.viewLine.transform = CGAffineTransform(translationX: self.view.frame.size.width/2, y: 0)
            })
            btnTheatersDisabled()
        }
        else{
            UIView.animate(withDuration: 0.2, animations: {
                self.viewLine.transform = CGAffineTransform.identity
            })
            
            btnMoviesDisabled()
        }
        
    }
    // MARK: - Button Methods and Actions
    func btnMoviesDisabled(){
        btnMovies.isUserInteractionEnabled=false
        btnTheaters.isUserInteractionEnabled=true
    }
    func btnTheatersDisabled(){
        btnMovies.isUserInteractionEnabled=true
        btnTheaters.isUserInteractionEnabled=false
    }
    
    @IBAction func actionMoviesClicked(_ sender: Any) {
        btnMoviesDisabled()
        UIView.animate(withDuration: 0.2, animations: {
            self.viewLine.transform = CGAffineTransform.identity
        })
        pageViewController.setViewControllers([orderedViewControllers.first!], direction: .reverse, animated: true, completion:{(_ finished: Bool) -> Void in
            self.pageId=(self.orderedViewControllers.first?.restorationIdentifier)!
        })

    }
    @IBAction func actionTheatersClicked(_ sender: Any) {
        btnTheatersDisabled()
        UIView.animate(withDuration: 0.2, animations: {
            self.viewLine.transform = CGAffineTransform(translationX: self.view.frame.size.width/2, y: 0)
        })
        pageViewController.setViewControllers([orderedViewControllers.last!], direction: .forward, animated: true, completion:{(_ finished: Bool) -> Void in
            self.pageId=(self.orderedViewControllers.last?.restorationIdentifier)!
        })
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        let alert = UIAlertController(title: "What do you want to add?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Add Cinema Hall", style: UIAlertActionStyle.default, handler: { action in
            
            self.performSegue(withIdentifier: "toCinemaDetails", sender: self)
            
        }))
        alert.addAction(UIAlertAction(title: "Add Movie", style: UIAlertActionStyle.default, handler: { action in
            
            // do something like...
             self.performSegue(withIdentifier: "toMovieDetails", sender: self)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    

    
}
