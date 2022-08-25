//
//  FormPageTableViewController.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

protocol CellButtonDelegate: AnyObject {
    func cellButtonTapped()
}

protocol CustomCellUpdater: AnyObject {
    func updateTableView()
}

class FormPageTableViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableViewFooterView: UIView!
    
    //MARK: - Properties
    
    var formPage: FormPage?
    weak var delegate: PageNavigationDelegate?
    
    private var hiddenSections = Set<Int>()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        addKeyboardObservers()
        setupHideKeyboardGestureRecognizer()
    }
    
    //MARK: - Actions
    
    @IBAction func nextButtonTapped() {
        guard let formPage = formPage else { return }
        
        if formPage.isValid().validation {
            delegate?.nextPageTapped()
        } else {
            formTableView.reloadData()
            let invalidItems = formPage.isValid().invalidItems.compactMap { $0 }
            print(invalidItems)
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        delegate?.previousPageTapped()
    }
}

//MARK: - UITableViewDataSource Methods

extension FormPageTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let formSections = self.formPage?.formSections else { return 0 }
        return formSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.formPage?.formSections[section] else { return 0 }
        let items = section.items
        
        return section.isCollapsed ? 0 : items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createAndUpdateCells(forSection: indexPath.section, indexPath: indexPath)
    }
    
    func createAndUpdateCells(forSection section: Int, indexPath: IndexPath) -> UITableViewCell {
        guard let section = self.formPage?.formSections[section] else { return UITableViewCell() }
        
        let item = section.items[indexPath.row]
        let cellType = item.uiProperties.cellType
        
        guard let cell = cellType?.dequeueCell(for: formTableView, at: indexPath) else { return UITableViewCell() }
        
        if let cell = cell as? FormTextFieldTableViewCell, let isCellButtonHidden = cell.isSendButtonHidden {
            if !isCellButtonHidden {
                cell.cellButtonDelegate = self
            }
        }
        
        if let formUpdatableCell = cell as? FormUpdatable {
            item.indexPath = indexPath
            formUpdatableCell.update(with: item)
        }
        
        if let cell = cell as? CellUpdatable {
            cell.cellUpdaterDelegate = self
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - UITableViewDelegate Methods

extension FormPageTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let formSection = formPage?.formSections[section], let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: CollapsibleTableViewHeader.self)) as? CollapsibleTableViewHeader else { return UIView() }
        
        header.titleLabel.text = formSection.name
        header.arrowLabel.text = "^"
        header.setCollapsed(formSection.isCollapsed)
        header.section = section
        
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let formSection = formPage?.formSections[section] else { return 0 }
        
        return formSection.isCollapsed ? 0 : 16
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
}

// MARK: - Section Header Delegate

extension FormPageTableViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        guard let formSection = formPage?.formSections[section] else { return }
        view.endEditing(true)
        
        let collapsed = !formSection.isCollapsed
        
        // Toggle collapse
        formPage?.formSections[section].isCollapsed = collapsed
        header.setCollapsed(collapsed)
        formTableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

extension FormPageTableViewController: CellButtonDelegate {
    func cellButtonTapped() {
        //TODO: - Send mail invitation or whatever else the cell button does.
    }
}

//MARK: - Private Methods

private extension FormPageTableViewController {
    func setupTableView() {
        
        PageItemCellType.registerCells(for: formTableView)
    }
    func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            formTableView.contentInset = .zero
        } else {
            formTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        UITableView.performWithoutAnimation {
            formTableView.scrollIndicatorInsets = formTableView.contentInset
            formTableView.scrollToNearestSelectedRow(at: .middle, animated: true)
        }
    }
    
    func setupHideKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}

extension FormPageTableViewController: CustomCellUpdater {
    func updateTableView() {
        UITableView.performWithoutAnimation {
            formTableView.reloadData()
        }
    }
}
