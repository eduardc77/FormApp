//
//  FormContainerViewController.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/18/21.
//

import UIKit

protocol PageNavigationDelegate: AnyObject {
    func nextPageTapped()
    func previousPageTapped()
}

class FormContainerViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var progressCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressBar: CircularProgressView!
    @IBOutlet weak var savedLabel: UILabel!
    
    //MARK: - Properties
    
    var form: Form?
    var formPages = [FormPageTableViewController]()
    
    var pageViewController: UIPageViewController?
    var currentPage = 0
    var isTransitionAnimationFinished = true
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFormPages()
        setupPageViewController()
        setupPageProgressCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - PageNavigationDelegate

extension FormContainerViewController: PageNavigationDelegate {
    func nextPageTapped() {
        if currentPage == formPages.count - 1 {
            guard let successViewController = UIStoryboard(name: "RegistrationFlow", bundle: nil).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController else { return }
            
            navigationController?.pushViewController(successViewController, animated: true)
        } else {
            scrollToNextPage()
        }
    }
    
    func previousPageTapped() {
        scrollToPreviousPage()
    }
}

//MARK: - Private Methods

private extension FormContainerViewController {
    func setupPageViewController() {
        
        pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        guard let pageViewController = pageViewController else { return }
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.frame = containerView.bounds
        
        pageViewController.setViewControllers([formPages[0]], direction: .forward, animated: false)
        toggleSavedLabelHidden()
    }
    
    func setupFormPages() {
        guard let form = form else { return }
        
        for formPage in form.pages {
            guard let formTableViewController = UIStoryboard(name: "RegistrationFlow", bundle: nil).instantiateViewController(withIdentifier: "FormTableViewController") as? FormPageTableViewController else { return }
            formTableViewController.formPage = formPage
            formTableViewController.delegate = self
            
            formPages.append(formTableViewController)
        }
    }
    
    func setupPageProgressCollectionView() {
        progressCollectionView.register(UINib(nibName: "PageProgressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageProgressCollectionViewCell")
        progressCollectionView.isScrollEnabled = false
    }
    
    func scrollTo(viewController: UIViewController,
                  direction: UIPageViewController.NavigationDirection = .forward) {
        pageViewController?.setViewControllers([viewController],
                                               direction: direction,
                                               animated: true,
                                               completion: { (finished) -> Void in
                                                if finished {
                                                    switch direction {
                                                    case .forward:
                                                        self.currentPage += 1
                                                    case .reverse:
                                                        self.currentPage -= 1
                                                        
                                                    @unknown default: break
                                                    }
                                                    self.toggleSavedLabelHidden()
                                                    self.isTransitionAnimationFinished = true
                                                }
                                               })
    }
    
    func scrollToNextPage() {
        guard isTransitionAnimationFinished else { return }
        isTransitionAnimationFinished = false
        
        let indexPath = IndexPath(item: currentPage + 1, section: 0)
        guard currentPage < formPages.count - 1, let cell = progressCollectionView.cellForItem(at: indexPath) as? PageProgressCollectionViewCell else {
            isTransitionAnimationFinished = true
            return
        }
        
        
        let nextViewController = formPages[currentPage + 1]
        scrollTo(viewController: nextViewController)
        
        cell.valueCompletion?(true)
        
        progressCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        
        updateProgressView(with: .forward)
    }
    
    
    func scrollToPreviousPage() {
        guard isTransitionAnimationFinished else { return }
        isTransitionAnimationFinished = false
        let indexPath = IndexPath(item: currentPage, section: 0)
        
        guard currentPage > 0, let cell = progressCollectionView.cellForItem(at: indexPath) as? PageProgressCollectionViewCell else {
            isTransitionAnimationFinished = true
            navigationController?.popViewController(animated: true)
            navigationController?.navigationBar.isHidden = false
            
            return
        }
        
        cell.valueCompletion?(false)
        let previousViewController = formPages[currentPage - 1]
        progressCollectionView.scrollToItem(at: IndexPath(item: currentPage - 1, section: 0), at: .left, animated: true)
        updateProgressView(with: .reverse)
        
        scrollTo(viewController: previousViewController, direction: .reverse)
    }
    
    func updateProgressView(with progressDirection: UIPageViewController.NavigationDirection) {
        var progress: Double = 0
        switch progressDirection {
        case .forward:
            progress = Double(currentPage + 1) / Double(formPages.count)
        case .reverse:
            progress = Double(currentPage - 1) / Double(formPages.count)
        default: break
        }
        
        progressBar.updateProgress(CGFloat(progress), animated: true, initialDelay: 0.2, duration: 0.6, completion: nil)
        
        let progressRounded = (Int((progress * 100).rounded(.up)))
        let progressPercent = 10 * Int((progressRounded) / 10)
        
        savedLabel.text = "Saved \(progressPercent)%"
    }
    
    func toggleSavedLabelHidden() {
        savedLabel.isHidden = currentPage != 0 ? false : true
    }
}

//MARK: - UICollectionViewDataSource Methods

extension FormContainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let form = form else { return 0 }
        
        return form.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let form = form, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageProgressCollectionViewCell", for: indexPath) as? PageProgressCollectionViewCell else { return UICollectionViewCell() }
        
        cell.pageTitleLabel.text = ""
        cell.setupCellWith(title: form.pages[indexPath.row].title)
        
        if indexPath.item == 0 {
            cell.valueCompletion?(true)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate Methods

extension FormContainerViewController: UICollectionViewDelegate {}
