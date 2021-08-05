//
//  ARViewController.swift
//  NeighborhoodHistory
//
//  Created by Matthew Poelsterl on 8/5/21.
//

import UIKit
import RealityKit

class ARViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create 3D Ball
        let sphere = MeshResource.generateSphere(radius: 0.1)
        let material = SimpleMaterial(color: .black, roughness: 0, isMetallic: true)
        
        let sphereEntity = ModelEntity(mesh: sphere, materials: [material])
        
        //Create anchor
        let sphereAnchor = AnchorEntity(world: SIMD3(x: 0, y: 0, z: 0))
        sphereAnchor.addChild(sphereEntity)
        
        //Add anchor to scene
        arView.scene.addAnchor(sphereAnchor)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
