//
//  MyAssetsViewModel.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/20.
//

import Foundation


class MyTaxViewModel {
  
    var taxRemainingDays: String = ""
    var expectedTax: ExpectedTax?
    var isCalcTaxDone: Bool?
    var taxBasis: TaxBasis?
    
    func getMyTaxData(GetFinishedHandler: @escaping () -> ()) {
        getMyTax(basic_year: "2021", symbol: "", GetTaxInfoHandler: { result in
            switch result {
            case let .success(result):
                
                guard let more = result.more else { return }
                guard let taxRemainingDays = more.taxRemainingDays else { return }
                guard let expectedTax = more.expectedTax else { return }
                guard let isCalcTaxDone = more.isCalcTaxDone else { return }
                guard let taxBasis = more.taxBasis else { return }
                
                self.taxRemainingDays = taxRemainingDays
                self.expectedTax = expectedTax
                self.isCalcTaxDone = isCalcTaxDone
                self.taxBasis = taxBasis
                
                GetFinishedHandler()
            case let .failure(error):
                print(error)
            }
        })
    }
    
    
    
    
    func getMyTax(basic_year: String, symbol: String, GetTaxInfoHandler: @escaping (Result<MyTaxResponseModel, Error>) -> Void) {
        // n1hwShMDXUrY1jLitXf/0g==
        // UserInfo().getUserSession()x
        MyTaxConnections().taxInfo(basic_year: basic_year, session: UserInfo().getUserSession(), MyTaxHandler: { result in
            switch result {
            case let .success(result):
                GetTaxInfoHandler(.success(result))
            case let .failure(error):
                GetTaxInfoHandler(.failure(error))
            }
        })
    }

}
