//
//  UserListViewRow.swift
//  RandomUsers
//
//  Created by Insu Park on 10/4/23.
//

import SwiftUI

struct UserListViewRow: View {
    
    var item: UserListItemViewModel
    
    var body: some View {
        HStack {
            Image("no_image", bundle: nil)
                .resizable()
                .frame(width: 80, height: 80)
            VStack {
                Text("USERNAME")
                Text("AddressInfo")
            }
        }
    }
}

//#if DEBUG
//@available(iOS 13.0, *)
//struct UserListViewRow_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        UserListViewRow(
//            item: UserListItemViewModel(id: <#ObjectIdentifier#>, thumbnail: <#String#>, username: <#String#>, addressInfo: <#String#>)
//        )
//    }
//    
//}
//#endif
