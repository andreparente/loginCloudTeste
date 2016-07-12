//
//  ViewController.swift
//  loginCloud
//
//  Created by Andre Machado Parente on 7/11/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.actOnNotificationIDReceived), name: "notificationIDReceived", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(sender: AnyObject) {
        
        //BOTAR NEGOCIO DE ACTIVITY INDICATOR
        dispatch_async(dispatch_get_main_queue(),{
            
            if(DAO().cloudAvailable()) {
                
                DAO().getCloudID() {
                    recordID, error in
                    
                    if let userID = recordID?.recordName {
                        print("received iCloudID \(userID)")
                        auxID = userID
                        //userLogged.userID = auxID
                        
                    } else {
                        print("Fetched iCloudID was nil")
                    }
                }
                
                
            }
                
            else {
                
                //tratar erro de nem estar logado no icloud
                print("ICLOUD NEM TA LOGADO PORRA")
                //dar aviso ao usuário
                exit(0)
            }
        })
    }
    
    //FUNCAO QUE LOGA, UMA VEZ QUE FOI RECUPERADO O ID DA PESSOA, AI DENTRO PODE TAMBEM INICIALIZAR AS CATEGORIAS E OS GASTOS
    func actOnNotificationIDReceived() {
        
        dispatch_async(dispatch_get_main_queue(),{

        defaults.setObject(auxID, forKey: "cloudID")
        userLogged = User(ID: auxID)
        self.dismissViewControllerAnimated(true, completion: nil)
        })
    }

}

