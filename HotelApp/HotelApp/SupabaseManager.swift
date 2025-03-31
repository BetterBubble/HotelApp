//
//  File.swift
//  HotelApp
//
//  Created by Александр Шульга on 31.03.2025.
//

import Supabase
import Foundation

class SupabaseManager {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        let supabaseUrl = URL(string: "https://vxnhnzhqzxvmalhqlbci.supabase.co")!
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4bmhuemhxenh2bWFsaHFsYmNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM0MDU4MDAsImV4cCI6MjA1ODk4MTgwMH0.epn2Pr4u5Sm_Bbao1oCjKBsgAZobD0Uxm25hgJuwqMs"
        
        self.client = SupabaseClient(
            supabaseURL: supabaseUrl,
            supabaseKey: supabaseKey
        )
    }
}
