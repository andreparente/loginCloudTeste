//
//  MainViewController.swift
//  loginCloud
//
//  Created by Andre Machado Parente on 7/11/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var labelID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.actOnNotificationIDReceived), name: "notificationIDReceived", object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actOnNotificationIDReceived() {
        
        //dar hidden = false nas views e paradas

            //se nao for a mesma conta, faz um tratamento, avisa que mudou a conta ou algo do tipo
            if defaults.objectForKey("cloudID") as? String != auxID {
                
                print("auxID:::::::", auxID)
                print(defaults.objectForKey("cloudID") as? String)
                print("ta entrando aqui onde nao devia")
            }
                
                //se for a mesma conta, recupera a View
            else {
                
                userLogged = User(ID: auxID)
                self.carregaView()
                print("ta entrando aqui")
            }
        
    }
    

    override func viewWillAppear(animated: Bool) {
        
        
        //verifica se ta logado no Cloud ou nao, independente se é primeira vez/outra conta/ou nao é primeira vez.
        if defaults.objectForKey("cloudID") == nil {
        
            //nao sei porque mas ta funcionando por enquanto
        }
        
        else {
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
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //se for a primeira vez no app!
        if defaults.objectForKey("cloudID") == nil {
            performSegueWithIdentifier("MainToLogin", sender: self)
        }

    }

    func carregaView() {
        //funçao pra carregar as coisas do ICloud e tal, os gastos, categorias e tudo mais
        print("entrou na carregaView")
        labelID.text = userLogged.userID
    }

}
