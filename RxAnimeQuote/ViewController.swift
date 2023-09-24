//
//  ViewController.swift
//  RxAnimeQuote
//
//  Created by User on 24/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.getQutote(with: weakSelf.textField.text)
            }).disposed(by: disposeBag)
    }
    
    private func getQutote(with title: String?) {
        guard let unwrappedTitle = title, !unwrappedTitle.isEmpty, let url = AnimeParams(query: unwrappedTitle).url else {
            updateView(with: AnimeError.emptyError)
            return }
        Requester.fetchData(with: url)
            .catchErrorJustReturn([:])
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                guard let weakSelf = self else { return }
                guard let unwrappedData = data as? [String: AnyObject] else { return }
                if let model = AnimeModel(attributes: unwrappedData) {
                    weakSelf.updateView(with: model)
                } else {
                    let errorModel = AnimeError(attributes: unwrappedData)
                    weakSelf.updateView(with: errorModel.error)
                }
            }).disposed(by: disposeBag)
    }
    
    private func configureView() {
        characterLabel.isHidden = true
        quoteLabel.text = "Write anime name to begin search"
        quoteLabel.textColor = .black
    }
    
    private func updateView(with model: AnimeModel) {
        characterLabel.isHidden = false
        characterLabel.text = model.character
        quoteLabel.text = model.quote
        quoteLabel.textColor = .black
    }
    
    private func updateView(with error: String) {
        characterLabel.isHidden = true
        quoteLabel.text = error
        quoteLabel.textColor = .red
    }
}

